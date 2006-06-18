Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWFRPG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWFRPG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 11:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWFRPG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 11:06:58 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:46741 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751133AbWFRPG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 11:06:57 -0400
Date: Sun, 18 Jun 2006 17:06:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Con Kolivas <kernel@kolivas.org>
cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-ck1
In-Reply-To: <200606181736.38768.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.61.0606181703380.8787@yvahk01.tjqt.qr>
References: <200606181736.38768.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>These are patches designed to improve system responsiveness and interactivity. 
>It is configurable to any workload but the default ck patch is aimed at the 
>desktop and cks is available with more emphasis on serverspace.
>
Last time (2.6.17-rc6-ck1), I had a strange experience over the regular 
scheduler. When three gccs were competing for time, each of them got a time 
window of 1/3 second in which each ran at 99%.
The regular scheduler does it in a way so that each time window is as small 
as possible, that is, top shows 33% for each process on low top 
udating intervals like 0.1 sec.
This behavior was not observed with 2.6.16-rcX-ck.


Jan Engelhardt
-- 
