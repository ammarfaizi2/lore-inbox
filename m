Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317367AbSGZI1P>; Fri, 26 Jul 2002 04:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317374AbSGZI1P>; Fri, 26 Jul 2002 04:27:15 -0400
Received: from dsl-213-023-020-025.arcor-ip.net ([213.23.20.25]:15326 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317367AbSGZI1P>;
	Fri, 26 Jul 2002 04:27:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "David Luyer" <david@luyer.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.18-rc3-ac3: bug with using whole disks as filesystems
Date: Fri, 26 Jul 2002 10:31:38 +0200
X-Mailer: KMail [version 1.3.2]
References: <004a01c233ba$1a764f50$638317d2@pacific.net.au> <E17Xxjj-0005XT-00@starship>
In-Reply-To: <E17Xxjj-0005XT-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Y0Vf-0006iv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 July 2002 07:33, I wrote:
> There is no fundamental reason why we can't handle the larger
> blocksizes.  It just didn't make it to the top of the list of things
> to do for this cycle.  For now, all the mkfs's have to accomodate
> this shortcoming.

Whoops, correction, the correct behaviour is to refuse to mount a
filesystem that has oversize blocks.  Mkfs can and should go ahead and
create such things if asked to.

-- 
Daniel
