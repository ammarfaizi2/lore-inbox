Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265545AbUGITUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbUGITUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 15:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbUGITUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 15:20:35 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:30878 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265545AbUGITUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 15:20:30 -0400
From: jmerkey@comcast.net
To: harlan@artselect.com (Pete Harlan)
Cc: Hans Reiser <reiser@namesys.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Date: Fri, 09 Jul 2004 19:20:29 +0000
Message-Id: <070920041920.2370.40EEEFFD000B341B000009422200763704970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> Reiser3 lets a directory have more than 32000 subdirectories already.
> I ran into this problem two weeks ago on an ext3 filesystem and found
> Reiser didn't have the problem.  My reiser3 directory had 1million+
> subdirs before I killed my test program.
> 
> I believe it still has a similar limit on the number of hard links,
> but it doesn't implement ".." as a hard link.
> 
> --Pete
> 
> 

NetWare has always supported more than this, so this whole idea of fixed inode tables 
is somewhat strange to me to start with.  I am still looking through Hans code, but if 
this is accurate I'll just take a system out Monday and see if it works.  My only concern 
with Reiser has to do with the bug reports I've seen on it over the years, but Suse is 
shipping it as default, and we have been running it here for about a year on a production 
server.  I'll post if it crashes, corrupts data, or has problems.  

Jeff



