Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbTH0JKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 05:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTH0JKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 05:10:46 -0400
Received: from ifi.informatik.uni-stuttgart.de ([129.69.211.1]:10417 "EHLO
	ifi.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S263210AbTH0JKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 05:10:44 -0400
Date: Wed, 27 Aug 2003 11:10:40 +0200
From: "Marcelo E. Magallon" <mmagallo@debian.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH,BACKPORT] AGPGART support for Intel 7205/7505 chipsets
Message-ID: <20030827091040.GA5935@informatik.uni-stuttgart.de>
Mail-Followup-To: "Marcelo E. Magallon" <mmagallo@debian.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <20030826122611.GA26314@informatik.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20030826122611.GA26314@informatik.uni-stuttgart.de>
X-Operating-System: Linux techno 2.4.21-ck1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2003 at 02:26:12PM +0200, Marcelo E. Magallon wrote:

 >  Ok, here's the patch again against what's current in the BK tree.  I
 >  just checked that it still applies and works with 2.4.22.

 I am sorry, I just noticed I omitted the diff of the include/linux
 directory.  The missing bits are attached.  The whole patch is
 available from:

           http://people.debian.org/~mmagallo/agp-i7x05.diff

 Cheers,

 Marcelo

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="agp-i7x05-defines.diff"

Index: include/linux/agp_backend.h
===================================================================
--- include/linux/agp_backend.h	(revision 3835)
+++ include/linux/agp_backend.h	(working copy)
@@ -55,6 +55,8 @@
 	INTEL_I855_PM,
 	INTEL_I860,
 	INTEL_I865_G,
+	INTEL_I7205,
+	INTEL_I7505,
 	VIA_GENERIC,
 	VIA_VP3,
 	VIA_MVP3,

--y0ulUmNC+osPPQO6--
