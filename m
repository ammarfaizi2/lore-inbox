Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTE0KCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTE0KCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:02:36 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:31370 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S263182AbTE0KCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:02:33 -0400
Date: Tue, 27 May 2003 12:15:43 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: torvalds@transmeta.com,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
Message-ID: <20030527101543.GA4351@lps.ens.fr>
References: <200305271012.h4RACbE04869@quatramaran.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200305271012.h4RACbE04869@quatramaran.ens.fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  there's been too much delay between 69 and 70, but I was hoping to make 
> 70 the last "Linus only" release before getting together with Andrew and 
> figuring out how to start the "pre-2.6" series and more of a code slush. 
Hello;

I need this to compile:

Regards,

-- 
	Éric Brunet


--- linux-2.5.70/drivers/video/i810/i810.h.orig	2003-05-27 12:02:51.334162312 +0200
+++ linux-2.5.70/drivers/video/i810/i810.h	2003-05-27 12:10:33.283935272 +0200
@@ -203,8 +203,8 @@
 #define LOCKUP                      8
 
 struct gtt_data {
-	agp_memory *i810_fb_memory;
-	agp_memory *i810_cursor_memory;
+	struct agp_memory *i810_fb_memory;
+	struct agp_memory *i810_cursor_memory;
 };
 
 struct mode_registers {
