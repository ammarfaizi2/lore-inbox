Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWHPShK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWHPShK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWHPShK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:37:10 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:30668 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932185AbWHPShJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:37:09 -0400
Date: Wed, 16 Aug 2006 14:37:07 -0400
To: Dirk <noisyb@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
Message-ID: <20060816183707.GD13641@csclub.uwaterloo.ca>
References: <44E3552A.6010705@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E3552A.6010705@gmx.net>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:26:02PM +0200, Dirk wrote:
> I have changed a message that didn't clearly tell the user what was goin
> on...
> 
> Please have a look!

Perhaps the real problem is that some @#$@#$ user space task is
constantly trying to mount the disc while something else is trying to
write to it.

gnome and kde both seem very eager to implement such things.  perhaps
there should be a way to prevent any access by such processes while
writing to the disc.

--
Len Sorensen
