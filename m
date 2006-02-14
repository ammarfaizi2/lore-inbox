Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWBNAIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWBNAIL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWBNAIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:08:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:64397 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964863AbWBNAIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:08:09 -0500
Date: Tue, 14 Feb 2006 01:08:07 +0100
From: Olaf Hering <olh@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hannes Reinecke <hare@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: calibrate_migration_costs takes ages on s390
Message-ID: <20060214000807.GA6188@suse.de>
References: <20060213102634.GA4677@osiris.boeblingen.de.ibm.com> <20060213104645.GA17173@elte.hu> <20060213234254.GA5368@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060213234254.GA5368@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Feb 14, Olaf Hering wrote:

> We did a bit of testing, -rc2-git3 + the patch below was still ok.
> 
>  [PATCH] s390: earlier initialization of cpu_possible_map
>  9733e2407ad2237867cb13c04e7d619397fa3090

I need to double check, but -git5 + that patch was reported to be slow.
