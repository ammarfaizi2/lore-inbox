Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVKCJme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVKCJme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 04:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVKCJme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 04:42:34 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:35271 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932159AbVKCJmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 04:42:33 -0500
Date: Thu, 3 Nov 2005 10:42:31 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Jean-Christian de Rivaz <jc@eclis.ch>
cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: NTP broken with 2.6.14
In-Reply-To: <4369641D.6020301@eclis.ch>
Message-ID: <Pine.LNX.4.61.0511030306150.1387@scrub.home>
References: <4369464B.6040707@eclis.ch> <Pine.LNX.4.61.0511030134580.1387@scrub.home>
 <4369641D.6020301@eclis.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 3 Nov 2005, Jean-Christian de Rivaz wrote:

> talla:~# zcat /proc/config.gz | egrep HZ
> # CONFIG_HZ_100 is not set
> CONFIG_HZ_250=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=250

It's possible that it works again, if you change this back to 1000, but 
that would mean something is still wrong.
Could you compare the compare the boot messages, if you find any 
suspicious differences?

bye, Roman
