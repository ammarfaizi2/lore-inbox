Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUKIFDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUKIFDd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbUKIFDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:03:33 -0500
Received: from cantor.suse.de ([195.135.220.2]:59306 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261366AbUKIFDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:03:31 -0500
Date: Tue, 9 Nov 2004 06:01:07 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Use -ffreestanding?
Message-ID: <20041109050107.GA5328@wotan.suse.de>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de> <20041108153436.GB9783@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de> <20041108175120.GB27525@wotan.suse.de> <20041108183449.GC15077@stusta.de> <20041108190130.GA2564@wotan.suse.de> <20041108233806.GM15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108233806.GM15077@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why doesn't the kernel use -ffreestanding which should prevent all such 
> problems?

Because we want most of these optimizations. Also with -ffreestanding
you would need to supply the out of line string functions anyways 
because gcc wouldn't inline them.

-Andi
