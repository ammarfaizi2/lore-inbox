Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276181AbRJCNA1>; Wed, 3 Oct 2001 09:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276176AbRJCNAS>; Wed, 3 Oct 2001 09:00:18 -0400
Received: from ci176196-a.grnvle1.sc.home.com ([24.4.120.228]:19865 "EHLO
	rhino") by vger.kernel.org with ESMTP id <S276181AbRJCNAL>;
	Wed, 3 Oct 2001 09:00:11 -0400
Subject: Re: [POT] Which journalised filesystem ?
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: lk <linux-kernel@vger.kernel.org>
Cc: Dave Jones <davej@suse.de>
In-Reply-To: <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de>
X-Mailer: Evolution/0.13 (Preview Release)
Date: 03 Oct 2001 09:00:32 -0400
Message-Id: <1002114032.4911.3.camel@rhino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-03 at 08:54, Dave Jones wrote:

> I've similar experiences with ext3, except for one bad instance
> recently when I put it on my laptop. Lots of asserts were triggered,
> and on reboot it couldn't find the journal, the superblock,
> or the backup superblocks. I spent a few hours trying to get data
> back, and eventually gave up and reformatted as ext2.
> 
> Alan mentioned this was something to do with the IBM hard disk
> having strange write-cache properties that confuse ext3.
> I'm not sure if this has been fixed or not yet, but its enough
> to make me think twice about trying it on the vaio for a while.
> 
> regards,
> 
> Dave.

I've been using ext3 on my ThinkPad (A20P) for about a month now with
nary the slightest problem.  I've even smoke tested it by shutting it
down in the middle of disk writes and it worked fine.

Billy



