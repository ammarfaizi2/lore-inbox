Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWISGVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWISGVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWISGVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:21:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6826 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964976AbWISGVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:21:50 -0400
From: Andi Kleen <ak@suse.de>
To: Robin Lee Powell <rlpowell@digitalkingdom.org>
Subject: Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM
Date: Tue, 19 Sep 2006 08:04:14 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060912223258.GM4612@chain.digitalkingdom.org> <p73bqpd62b2.fsf@verdi.suse.de> <20060918235854.GL4610@chain.digitalkingdom.org>
In-Reply-To: <20060918235854.GL4610@chain.digitalkingdom.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609190804.14786.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Done; it's at
> http://teddyb.org/~rlpowell/media/regular/lkml/hacked-boot.txt
> 
> Note that I had to us "mce=off acpi=off pci=conf1" to get any of
> that hack's output to show up at all; I wasn't clear whether you
> intended that or not.

Unfortunately with mce=off we can't see which device breaks.
Can you please boot with the patch and just 

acpi=off pci=conf1 ? 

and send the full output?

-Andi

