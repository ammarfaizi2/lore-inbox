Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbUKQKVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUKQKVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 05:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUKQKVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 05:21:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63880 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261929AbUKQKU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 05:20:59 -0500
Date: Wed, 17 Nov 2004 11:20:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: martin f krafft <madduck@madduck.net>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: about /proc/*/stat
In-Reply-To: <20041117092847.GA961@cirrus.madduck.net>
Message-ID: <Pine.LNX.4.53.0411171120320.13132@yvahk01.tjqt.qr>
References: <20041117092847.GA961@cirrus.madduck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If I look at /proc/meminfo, I see each number prefixed with a short
>identifying name. Looking at /proc/*/stat, however, I have to count
>fields to get to the field I want. I realise that it's probably not
>possible to change the format of this file (since it's read by
>ps(1), among others), but I wonder if you have any tools that parse
>it, similar to /proc/meminfo -- i.e. primarily for debugging?

fscanf(fp, "%d %d %d ... ", &status, &anotherthing,....)




Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
