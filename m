Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUI1WDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUI1WDa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUI1WD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:03:29 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:32660 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S268065AbUI1WBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:01:40 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
Date: Tue, 28 Sep 2004 15:01:36 -0700
User-Agent: KMail/1.7
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Lee Revell" <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>
References: <1094683020.1362.219.camel@krustophenia.net> <32791.192.168.1.5.1096405439.squirrel@192.168.1.5> <32901.192.168.1.5.1096408010.squirrel@192.168.1.5>
In-Reply-To: <32901.192.168.1.5.1096408010.squirrel@192.168.1.5>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409281501.40580.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is due in part b/c of the patches andrew merged that changed 
remap_page_range to remap_pfn_range. 

On Tuesday 28 September 2004 2:46 pm, Rui Nuno Capela wrote:
> This is another quirk on -mm4 I have found: I have a couple of outsider
> modules, both related to webcams, that fail on modprobe wrt same missing
> kernel symbol:
>
> w9968cf: Unknown symbol remap_page_range
> spca50x: Unknown symbol remap_page_range
>
> CU
