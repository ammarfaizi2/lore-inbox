Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWEOSnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWEOSnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWEOSnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:43:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43205 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750723AbWEOSnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:43:23 -0400
Message-ID: <4468CBC7.2030900@garzik.org>
Date: Mon, 15 May 2006 14:43:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060515182919.GA16070@irc.pl>
In-Reply-To: <20060515182919.GA16070@irc.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:
> On Mon, May 15, 2006 at 01:00:06PM -0400, Jeff Garzik wrote:
>> After much development and review, I merged a massive pile of libata
>> patches from Tejun Heo and Albert Lee.  This update contains the
>> following major libata
> 
>   Any plans to merge http://home-tj.org/wiki/index.php/Sil_m15w ? Or
> maybe it's merged already?
>   Seagate firmware update seems to be available only for OEMs, so this
> quirk is pretty helpful for end users.

Its a question of staging.  This still lives in the 'sii-m15w' branch of 
libata-dev.git, but if we throw too many _classes_ of changes into the 
same big lump, then it becomes much more difficult to discern which 
changes caused which failures.

Since sata_sil has seen several changes, and since the sii-m15w problems 
are so difficult to diagnose properly, its easier to separate that out.

	Jeff



