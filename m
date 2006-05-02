Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWEBOCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWEBOCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWEBOCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:02:54 -0400
Received: from dvhart.com ([64.146.134.43]:44763 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964806AbWEBOCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:02:53 -0400
Message-ID: <44576688.6050607@mbligh.org>
Date: Tue, 02 May 2006 07:02:48 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de>
In-Reply-To: <200605020905.29400.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh that's a 32bit kernel. I don't think the 32bit NUMA has ever worked
> anywhere but some Summit systems (at least every time I tried it it blew up 
> on me and nobody seems to use it regularly). Maybe it would be finally time to mark it 
> CONFIG_BROKEN though or just remove it (even by design it doesn't work very well) 

Bollocks. It works fine, and is tested every single day, on every git
release, and every -mm tree.

M.
