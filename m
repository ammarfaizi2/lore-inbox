Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268722AbUJEAiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268722AbUJEAiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268724AbUJEAiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:38:52 -0400
Received: from main.gmane.org ([80.91.229.2]:12231 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268722AbUJEAik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:38:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrew Rodland <arodland@entermail.net>
Subject: Re: 2.6.9-rc3-mm2
Date: Mon, 04 Oct 2004 20:36:01 -0400
Message-ID: <cjsqeb$8un$1@sea.gmane.org>
References: <20041004020207.4f168876.akpm@osdl.org> <20041004121528.GA4635@diamant.rubis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: port146.public4.resnet.ucf.edu
User-Agent: KNode/0.8.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Jourdois wrote:

> Hello,
> 
> This kernel does not boot on my i386 laptop. I have nothing after
> "Uncompressing kernel... Ok, booting linux". The fans are increasingly
> running, so I suspect cpu is heavily used at this time. I tried to
> wait several minutes, just to see.
> 
> I have the same problem since 2.6.9-rc2-mm2. Last booting kernel is
> 2.6.9-rc2-mm1. I tried every -mm kernel between -rc2-mm1 and -rc3-mm2.
> 
> Here is my .config for -rc3-mm2. Same config was used for -rc2-mm2,
> modulo new options.
> 


> CONFIG_PREEMPT_BKL=y

Try compiling with this one off; it seems to cause problems on some systems.


