Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbTIWXKv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTIWXKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:10:51 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:24337 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S263438AbTIWXKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:10:48 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: File access error fixed with mount -o remount ?
Date: Wed, 24 Sep 2003 00:09:59 +0100
User-Agent: KMail/1.5.3
References: <3F70CEA3.70905@jpl.nasa.gov>
In-Reply-To: <3F70CEA3.70905@jpl.nasa.gov>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309240009.59450.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 Sep 2003 23:52, Bryan Whitehead wrote:
> I have run across a problem with files that seem to become randomly
> "broken" but after a "mount -o remount" the files start working normally
> again.

I've had a vaguely similar problem with 2.6.0-test5: recently I've been 
compiling KDE over a period of a few days.  The first couple of days I was 
running test4, and everything was fine.  Then I upgraded to test5, and three 
times now I've had particular executables become unusable.  For example, 
yesterday, egrep just stopped working.  This stopped the KDE build, and 
testing it by hand, I found that running "egrep" gave me the error "text 
file busy."  I couldn't find any way of making it work again except a 
reboot.

Today it was "sed" that stopped being runnable with the same error message.  
I didn't try a remount (at the moment, my system is one big / partition.  
Yeah, I know...)  Again, sed didn't become runnable again until I rebooted.

Has anyone else seen this weirdness?  It's vanilla 2.6.0-test5, with 
reiserfs.

M

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
