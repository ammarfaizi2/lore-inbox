Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVCIX3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVCIX3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCIX1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:27:09 -0500
Received: from rutherford.zen.co.uk ([212.23.3.142]:31973 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S261199AbVCIX0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:26:39 -0500
Message-ID: <422F8623.4030405@cantab.net>
Date: Wed, 09 Mar 2005 23:26:27 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support for GEODE CPUs
References: <200503081935.j28JZ433020124@hera.kernel.org>	 <1110387668.28860.205.camel@localhost.localdomain>	 <20050309173344.GD17865@csclub.uwaterloo.ca> <1110405563.3072.250.camel@localhost.localdomain>
In-Reply-To: <1110405563.3072.250.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Rutherford-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> There are a few Geode tricks to know for performance
> 
> - If you can't turn it off use solid areas of colour to speed the system
> up (The hardware uses RLE encoding to reduce ram fetch bandwidth)

How much of a difference does the compression make to performance?

> - The onboard audio is a software SB emulation on older GX. It burns
> CPU.

Presumably one could write a native audio driver that didn't use the 
soundblaster emulation?

David Vrabel
