Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266928AbRGHRC7>; Sun, 8 Jul 2001 13:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbRGHRCt>; Sun, 8 Jul 2001 13:02:49 -0400
Received: from [194.213.32.142] ([194.213.32.142]:11268 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S266926AbRGHRCh>;
	Sun, 8 Jul 2001 13:02:37 -0400
Date: Sat, 30 Jun 2001 11:33:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: "Ph. Marek" <marek@bmlv.gv.at>, linux-kernel@vger.kernel.org
Subject: Re: Q: sparse file creation in existing data?
Message-ID: <20010630113349.B50@toy.ucw.cz>
In-Reply-To: <3.0.6.32.20010629133915.0091e470@pop3.bmlv.gv.at> <200106291838.f5TIcbAM015809@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200106291838.f5TIcbAM015809@webber.adilger.int>; from adilger@turbolinux.com on Fri, Jun 29, 2001 at 12:38:37PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It could be used as a replacement for the truncate code, because then
> truncate is simply a special case of punch, namely punch(0, end).

I do not think so. Truncate leaves you with filesize 0, while punch schould
leave you with filesize of original file.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

