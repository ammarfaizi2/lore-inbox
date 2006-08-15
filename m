Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWHOVu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWHOVu1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 17:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWHOVu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 17:50:26 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:26124 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750743AbWHOVu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 17:50:26 -0400
Message-ID: <44E2419B.2040505@argo.co.il>
Date: Wed, 16 Aug 2006 00:50:19 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Irfan Habib <irfan.habib@gmail.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Maximum number of processes in Linux
References: <3420082f0608151226h32dc20c1oe0b20549922c8f7@mail.gmail.com>
In-Reply-To: <3420082f0608151226h32dc20c1oe0b20549922c8f7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Aug 2006 21:50:24.0016 (UTC) FILETIME=[CFD58100:01C6C0B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Irfan Habib wrote:
>
> I have 1GB RAM and a p4 HT 3 GHz.
>
>
Use pthread_attr_setstacksize() to set a small stack size, and you'll 
get many more threads running.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

