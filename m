Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVCWHU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVCWHU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVCWHUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:20:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34729 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262838AbVCWHUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:20:09 -0500
Date: Wed, 23 Mar 2005 08:20:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Keith LeMay <keith.lemay@ultra-ats.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 High Memory Support for Pentium M
In-Reply-To: <OFC84D44E8.1772C89A-ON86256FCC.006CFB04@mail.apcinc.com>
Message-ID: <Pine.LNX.4.61.0503230818510.1493@yvahk01.tjqt.qr>
References: <OFC84D44E8.1772C89A-ON86256FCC.006CFB04@mail.apcinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>to a bug that was fixed in kernel version 2.4.26.  Does anyone know how the
>bug was fixed and what changes I need to port back into kernel version

tar -xvjf linux-2.4.25.tar.bz2
tar -xvjf linux-2.4.26.tar.bz2
diff -Pdpru linux-2.4.2[56] >changes.diff

and pick what's needed from changes.diff. That's what I would do in case I 
can't factor out the things that would stop me updating to 
2.4.26/2.6.something.

>2.4.22?  For various reasons, upgrading my system to kernel version 2.4.26
>is not an option.  Please respond to keith.lemay@ultra-ats.com.


Jan Engelhardt
-- 
