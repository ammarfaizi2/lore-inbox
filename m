Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWIUUhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWIUUhW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWIUUhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:37:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:51523 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750893AbWIUUhV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:37:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=QBvjKuobK/IxzmcGO4nWU3IpqlYyD+1+czo97Ii/7jGkE5GxSNnSWTm9cD/Y7E8ZfKBfPZsUJ5PiR0qiVOZkxWC6vQeUvSYf7r8HQhM416bX9YD4DFEEU7H+pOQeSl0i1vKWz81124K0tDW60usI2WPRBVpvMfYWpCUMjCGsqCM=
Date: Thu, 21 Sep 2006 22:37:10 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: jeff@garzik.org, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-Id: <20060921223710.d7472801.diegocg@gmail.com>
In-Reply-To: <20060921194604.GQ31906@stusta.de>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<45121382.1090403@garzik.org>
	<20060920220744.0427539d.akpm@osdl.org>
	<1158830206.11109.84.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609210819170.4388@g5.osdl.org>
	<20060921105959.a55efb5f.akpm@osdl.org>
	<Pine.LNX.4.64.0609211106391.4388@g5.osdl.org>
	<4512DB05.2090604@garzik.org>
	<20060921194604.GQ31906@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 21 Sep 2006 21:46:04 +0200,
Adrian Bunk <bunk@stusta.de> escribió:

> Even the kernel Bugzilla that contains only a small subset of all bug 
> reports contains 78 (sic) open bugs reported against 2.6.18-rc kernels [1].

I suspect that not many people is subscribed to the bugzilla mailing list,
not surprising since the URLs doesn't seem to be in the tree :)

After fixing my english, I wonder if the following patch could be applied...

Signed-off-by: Diego Calleja <diegocg@gmail.com>

--- 2.6/Documentation/HOWTO.OLD	2006-09-21 22:14:06.000000000 +0200
+++ 2.6/Documentation/HOWTO	2006-09-21 22:36:17.000000000 +0200
@@ -374,6 +374,26 @@ of information is needed by the kernel d
 problem.
 
 
+Managing bug reports
+--------------------
+
+One of the best ways to put into practice your hacking skills is by fixing 
+bugs reported by other people. Not only you will help to make the kernel
+more stable, you'll learn to fix real world problems and you will improve
+your skills, and other developers will be aware of your presence. Fixing
+bugs is one of the best ways to get merits between other developers, because
+not many people like wasting time fixing other people's bugs.
+
+To work in the already reported bug reports, go to http://bugzilla.kernel.org.
+If you want to be advised of the future bug reports, you can subscribe to the
+bugme-new mailing list (only new bug reports are mailed here) or to the
+bugme-janitor mailing list (every change in the bugzilla is mailed here)
+
+	http://lists.osdl.org/mailman/listinfo/bugme-new
+	http://lists.osdl.org/mailman/listinfo/bugme-janitors
+
+
+
 Mailing lists
 -------------
 
