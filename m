Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269610AbUJWBHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269610AbUJWBHO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269600AbUJWBGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:06:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:28602 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269760AbUJWBGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:06:39 -0400
Date: Sat, 23 Oct 2004 03:06:35 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de, pavel@ucw.cz
Subject: Re: [PATCH] HPET reenabling after suspend-resume
Message-ID: <20041023010635.GD16136@wotan.suse.de>
References: <20041022172659.A1632@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022172659.A1632@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 05:26:59PM -0700, Venkatesh Pallipadi wrote:
> 
> hpet hardware seems to need a little prodding during resume for it to start 
> sending the timer interupts again. Attached patch does it for both i386 
> and x86_64.

Hmm, what HPET hardware? It must have worked on some machines already,
otherwise suspend/resume would have never worked on many AMD x86-64 
machines. 


Anyways, looks good.

-Andi
