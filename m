Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWEBGse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWEBGse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 02:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWEBGse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 02:48:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:61911 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932409AbWEBGsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 02:48:33 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <20060419112130.GA22648@elte.hu>
	<20060420091856.GB21660@wotan.suse.de> <20060421112049.GA5609@elte.hu>
	<20060421114501.GA22570@elte.hu> <20060501124942.GA21918@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2006 08:48:31 +0200
In-Reply-To: <20060501124942.GA21918@elte.hu>
Message-ID: <p73aca07whs.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> FYI, even on 2.6.17-rc3 i get the one below. v2.6.17 showstopper i 
> guess?

Did you send a full boot log?

If it's using ACPI NUMA try numa=noacpi - it might be some problem
with the node discovery on your machine.

-Andi
