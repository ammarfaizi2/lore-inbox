Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751886AbWAOJvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbWAOJvY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 04:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWAOJvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 04:51:24 -0500
Received: from mx01.qsc.de ([213.148.129.14]:60109 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S1751886AbWAOJvX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 04:51:23 -0500
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Organization: ExactCODE
To: linux-kernel@vger.kernel.org
Subject: kbuild / KERNELRELEASE not rebuild correctly anymore
Date: Sun, 15 Jan 2006 10:51:14 +0100
User-Agent: KMail/1.9
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601151051.14827.rene@exactcode.de>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi all, with at least 2.6.15-mm{2,3,4} untaring the
	kernel and running make menuconfig (or most other favourite config
	tools) do not display a version anymore since .kernelrelease it not
	build as dependecy. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

with at least 2.6.15-mm{2,3,4} untaring the kernel and running make menuconfig
(or most other favourite config tools) do not display a version anymore since
.kernelrelease it not build as dependecy.

I only noticed this because my build scripts grab the version before the build for
later file names on installations and leave this string empty after configuration of
latest linux kernels.

Sincerely,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45
