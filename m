Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWHLRaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWHLRaL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWHLRaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:30:11 -0400
Received: from main.gmane.org ([80.91.229.2]:61677 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932578AbWHLRaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:30:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas Koeller <thomas@koeller.dyndns.org>
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
Date: Sat, 12 Aug 2006 17:27:13 +0000 (UTC)
Message-ID: <loom.20060812T191433-775@post.gmane.org>
References: <200608102318.04512.thomas.koeller@baslerweb.com> <1155326983.24077.119.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.39.177.93 (Mozilla/5.0 (compatible; Konqueror/3.5; Linux 2.6.17.7; de) KHTML/3.5.3 (like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan <at> lxorguk.ukuu.org.uk> writes:

> 
> Ar Iau, 2006-08-10 am 23:18 +0200, ysgrifennodd Thomas Koeller:
> > This is a driver used for image capturing by the Basler eXcite smart camera
> > platform.
> 
> drivers/media/video and the Video4Linux2 API deal with image capture in
> Linux. It provides a common API for video and thus image capture. Any
> reason that interface is not suitable.
> 
> Alan
> 
> 

This is not a driver for grabbing live video streams. The eXcite platform using 
it is a smart camera running linux, and the driver is for a very special piece 
of hardware designed into this camera. Its purpose is grabbing single image 
frames for processing within the camera itself, which is quite different from 
what the v4l2 API has been designed for.

For more information about the device, see 
http://www.baslerweb.com/beitraege/beitrag_en_18458.html.

I am not subscribed to lkml, so please cc my address thomas at koeller dot 
dyndns dot org on all replies.

Thomas



