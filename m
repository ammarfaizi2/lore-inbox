Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWKHToV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWKHToV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWKHToU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:44:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24722 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422691AbWKHToT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:44:19 -0500
Subject: Re: 2.6.19-rc1: Volanomark slowdown
From: Arjan van de Ven <arjan@infradead.org>
To: tim.c.chen@linux.intel.com
Cc: Olaf Kirch <okir@suse.de>, linux-kernel@vger.kernel.org,
       davem@sunset.davemloft.net, kuznet@ms2.inr.ac.ru,
       netdev@vger.kernel.org
In-Reply-To: <1163011132.10806.189.camel@localhost.localdomain>
References: <1162924354.10806.172.camel@localhost.localdomain>
	 <1163001318.3138.346.camel@laptopd505.fenrus.org>
	 <20061108162955.GA4364@suse.de>
	 <1163011132.10806.189.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 20:44:13 +0100
Message-Id: <1163015053.3138.378.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However, Volanomark is just a benchmark to alert us to changes.  
> If in real applications with small segment, this patch is 
> needed to fix congestion window adjustment as Dave pointed 
> out, and impact on bandwidth not as important, so be it.
> 
> Tim

if we can get the best of both worlds (by having the extra acks drop on
congestion) it's of course nicer ;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

