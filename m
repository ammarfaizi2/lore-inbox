Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbULOOCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbULOOCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 09:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbULOOCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 09:02:31 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:31389 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261258AbULOOC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 09:02:28 -0500
Message-ID: <3284684.1103119330673.JavaMail.tomcat@pne-ps1-sn1>
Date: Wed, 15 Dec 2004 15:02:10 +0100 (MET)
From: Voluspa <lista4@comhem.se>
Reply-To: lista4@comhem.se
To: mr@ramendik.ru
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [213.64.150.229]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've now booted all -rc kernels from 2.6.8 to 2.6.10-rc3 and examined the 
behaviour of a heavy session with the 3D program Blender with regards to 
screen freezes and mouse unresponsiveness during memory swap.

I find no problem when blender is the sole (large) application, but when a 
distributed computing client is running in the background the reported problems 
surface. I use http://folding.stanford.edu for protein folding. It runs 
with a default of nice 19 and sucks up every free CPU cycle. I've never 
seen it interfere with anything prior to this swap issue - been running 
it since 2000.

Guess kernel people will say "don't do that then"...

Mvh
Mats Johannesson

