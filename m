Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbSIWV3A>; Mon, 23 Sep 2002 17:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSIWV27>; Mon, 23 Sep 2002 17:28:59 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:36557 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261296AbSIWV2k>;
	Mon, 23 Sep 2002 17:28:40 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.35002.179075.973994@napali.hpl.hp.com>
Date: Mon, 23 Sep 2002 14:33:46 -0700
To: Daniel Phillips <phillips@arcor.de>
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, dmo@osdl.org, axboe@suse.de,
       _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <E17tanS-0003cl-00@starship>
References: <15759.26918.381273.951266@napali.hpl.hp.com>
	<20020923.135708.10698522.davem@redhat.com>
	<15759.34428.608321.969391@napali.hpl.hp.com>
	<E17tanS-0003cl-00@starship>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 23 Sep 2002 23:31:13 +0200, Daniel Phillips <phillips@arcor.de> said:

  Daniel> Why attempt to write 8 bytes on ia32 when only 4 are needed?

Even on ia32 you'll need 8 bytes if the controller is operated in DAC
mode (which is what you want for a machine with >4GB of memory), no?

	--david
