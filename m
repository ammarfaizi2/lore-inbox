Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRKSJ6O>; Mon, 19 Nov 2001 04:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277012AbRKSJ6F>; Mon, 19 Nov 2001 04:58:05 -0500
Received: from [195.63.194.11] ([195.63.194.11]:15876 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S276761AbRKSJ5r>; Mon, 19 Nov 2001 04:57:47 -0500
Message-ID: <3BF8D576.D03A0EB6@evision-ventures.com>
Date: Mon, 19 Nov 2001 10:48:38 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: Sven Vermeulen <sven.vermeulen@rug.ac.be>,
        Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: /sbin/mount and /proc/mounts difference
In-Reply-To: <Pine.LNX.4.30.0111181401140.13487-100000@cola.teststation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:
> 
> On Sun, 18 Nov 2001, Sven Vermeulen wrote:
> 
> > As you can see the notail-option of reiserfs isn't listed on /proc/mounts,
> > but it is on "mount".
> >
> > Does this have any particular reason?
> 
> mount writes everything to /etc/mtab and displays that when asked.

Not quite...

~/tmp# strings /bin/mount | grep mounts
Note that one does not really mount a device, one mounts
/proc/mounts
~/tmp#
