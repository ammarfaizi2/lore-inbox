Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbSIWVfm>; Mon, 23 Sep 2002 17:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbSIWVfm>; Mon, 23 Sep 2002 17:35:42 -0400
Received: from dsl-213-023-022-250.arcor-ip.net ([213.23.22.250]:65206 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261304AbSIWVfW>;
	Mon, 23 Sep 2002 17:35:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: DAC960 in 2.5.38, with new changes
Date: Mon, 23 Sep 2002 23:40:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, dmo@osdl.org, axboe@suse.de,
       _deepfire@mail.ru, linux-kernel@vger.kernel.org
References: <15759.26918.381273.951266@napali.hpl.hp.com> <E17tanS-0003cl-00@starship> <15759.35002.179075.973994@napali.hpl.hp.com>
In-Reply-To: <15759.35002.179075.973994@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17tawV-0003cu-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 September 2002 23:33, David Mosberger wrote:
> >>>>> On Mon, 23 Sep 2002 23:31:13 +0200, Daniel Phillips <phillips@arcor.de> said:
> 
>   Daniel> Why attempt to write 8 bytes on ia32 when only 4 are needed?
> 
> Even on ia32 you'll need 8 bytes if the controller is operated in DAC
> mode (which is what you want for a machine with >4GB of memory), no?

Firm maybe.  The current driver does not attempt to do that on ia32, and
you're saying it should?  In that case should the driver not have #define
DAC_64, or similar?

Daniel
