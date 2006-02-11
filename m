Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWBKWxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWBKWxS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWBKWxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:53:18 -0500
Received: from 74.red-82-159-197.user.auna.net ([82.159.197.74]:43919 "EHLO
	indy.cmartin.tk") by vger.kernel.org with ESMTP id S1750802AbWBKWxR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:53:17 -0500
From: Carlos =?iso-8859-1?q?Mart=EDn?= <carlos@cmartin.tk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG GIT] Unable to handle kernel paging request at virtual address e1380288
Date: Sat, 11 Feb 2006 23:54:02 +0100
User-Agent: KMail/1.9.1
Cc: Doug McNaught <doug@mcnaught.org>, marc@osknowledge.org,
       mrmacman_g4@mac.com, adobriyan@gmail.com, linux-kernel@vger.kernel.org
References: <20060210214122.GA13881@stiffy.osknowledge.org> <87psltsy56.fsf@asmodeus.mcnaught.org> <20060211131008.55f19bb6.akpm@osdl.org>
In-Reply-To: <20060211131008.55f19bb6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602112354.03198.carlos@cmartin.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 February 2006 22:10, Andrew Morton wrote:
> Doug McNaught <doug@mcnaught.org> wrote:
> > You have no idea what might have happened a second ago, or a minute
> > ago, or five minutes ago.  Corrupted memory is like a
> > time-bomb--things don't always break right away.
> > 
> 
> Probability this bug was caused by the nvidia module: 0.1%
> Probability this bug was caused by USB or SCSI: 99.9%
> 
> SCSI and USB device management remain quite buggy and we need all the help
> we can get in finding and fixing these problems.

I once had a PCI probe function OOPS with the nvidia module loaded. Previous 
run was alright, and rebooting with exact same setup worked the next time and 
never failed again for the time I was using the nvidia module on that 
computer.

I can't be positive that it was the nvidia module, but the probability of it 
having to do with it is quite high. It at least triggered something.

   cmn
-- 
Carlos Martín Nieto    |   http://www.cmartin.tk
Hobbyist programmer    |
