Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWF1TWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWF1TWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWF1TWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:22:00 -0400
Received: from gw.goop.org ([64.81.55.164]:37765 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751053AbWF1TV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:21:59 -0400
Message-ID: <44A2D6DA.1050607@goop.org>
Date: Wed, 28 Jun 2006 12:22:02 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@google.com>, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, apw@shadowen.org,
       linuxppc64-dev@ozlabs.org, drfickle@us.ibm.com
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org>	<20060628034215.c3008299.akpm@osdl.org>	<20060628034748.018eecac.akpm@osdl.org>	<44A29582.7050403@google.com> <20060628121102.638f08d9.akpm@osdl.org>
In-Reply-To: <20060628121102.638f08d9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Found a way to reproduce it - do `cat /proc/slabinfo > /dev/null' in a
> tight loop.  With that happening, a little two-way wasn't able to make
> it through `dbench 4' without soiling the upholstery.  Then bisection-searching.
>   
It's surprising it was so subtle.  I'd been running with that code for a 
month or so without a peep of problem...

    J
