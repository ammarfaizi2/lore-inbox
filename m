Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbTAGNLy>; Tue, 7 Jan 2003 08:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267397AbTAGNLy>; Tue, 7 Jan 2003 08:11:54 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:2019 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267396AbTAGNLx>;
	Tue, 7 Jan 2003 08:11:53 -0500
Date: Tue, 7 Jan 2003 13:18:43 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: fix "assignment from incopatible pointer type" in amd-k7-agp.c
Message-ID: <20030107131843.GA17176@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030107130639.GH25540@alhambra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030107130639.GH25540@alhambra>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 03:06:39PM +0200, Muli Ben-Yehuda wrote:
 > agp_bridge.gatt_table and agp_bridge.gatt_table_real are both
 > u32*. Cast unsignments to them from unsigned long*'s to u32*'s. 

Looks good, similar fixes also needed for sworks-agp.c by the
looks of things. I'll fix that up..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
