Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUH3Hpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUH3Hpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUH3Hpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:45:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32226 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266876AbUH3Hp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:45:27 -0400
Date: Sun, 29 Aug 2004 00:58:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] make swsusp produce nicer screen output
Message-ID: <20040828225845.GB505@openzaurus.ucw.cz>
References: <20040820152317.GA7118@linux.nu> <20040823174217.GC603@openzaurus.ucw.cz> <20040823200858.GA4593@linux.nu> <20040824214929.GA490@openzaurus.ucw.cz> <412F132D.3000606@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412F132D.3000606@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>And do we need to handle the case when nr_copy_pages < 100?
> >> 
> >It really should not crash. 100 pages is 4MB. Thats little low but
> >seems possible.
> 
> 400k IIUC :-), and although it seems impossible, we still should not 
> crash if we counted it wrong for some strange reason.
> 

Yup, you are right. Okay so make it "can display garbage but should
do no other harm on <100 pages".
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

