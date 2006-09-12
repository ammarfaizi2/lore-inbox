Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbWILMi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbWILMi4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWILMi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:38:56 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12505 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965212AbWILMiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:38:55 -0400
Message-ID: <4506AA5D.7090406@garzik.org>
Date: Tue, 12 Sep 2006 08:38:53 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Martin Lucina <mato@kotelna.sk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Standalone PATA drivers patch for testing
References: <20060912112056.GB4789@dezo.moloch.sk>
In-Reply-To: <20060912112056.GB4789@dezo.moloch.sk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Lucina wrote:
> Hi,
> 
> I'd like to help test the new libata-based PATA drivers since they solve
> specific problems I've been having with my workstation hardware (Intel
> ICH7 with SATA and PATA devices attached).  
> 
> Is there a way to obtain a standalone patch I can apply against a
> 2.6.17.X/2.6.18-rcX kernel or should I just use the -mm tree?  I grabbed
> Alan's patch-2.6.17-ide1.gz way back when but this is obviously now very
> much out of date.

You can easily generate it from libata-dev.git.

git diff master..upstream

