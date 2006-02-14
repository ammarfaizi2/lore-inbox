Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030586AbWBNOd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030586AbWBNOd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030587AbWBNOd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:33:27 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:37807 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1030586AbWBNOd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:33:26 -0500
Message-ID: <43F1EA2B.4090203@ens-lyon.org>
Date: Tue, 14 Feb 2006 09:33:15 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3-mm1
References: <20060214014157.59af972f.akpm@osdl.org>
In-Reply-To: <20060214014157.59af972f.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc3/2.6.16-rc3-mm1/
>
>  
>

Hi Andrew,

WARNING: speedstep-centrino.ko needs unknown symbol cpu_online_map

This symbol is in include/linux/cpumask.h but actually only defined and
exported in smpboot.c which is not compiled on UP.

Regards,
Brice

