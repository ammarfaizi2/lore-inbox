Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWB0P0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWB0P0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWB0P0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:26:21 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:52135 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751462AbWB0P0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:26:21 -0500
Date: Mon, 27 Feb 2006 09:26:15 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] proc cleanup.
Message-ID: <20060227152615.GA19025@sergelap.austin.ibm.com>
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> 
> When working on pid namespaces I keep tripping over /proc.
> It's hard coded inode numbers and the amount of cruft
> accumulated over the years makes it hard to deal with.
> 
> So to put /proc out of my misery here is a series of patches that
> removes the worst of the warts.
> 
> The first patch which introduces task_refs is used later to address
> one of the worst faults how much low kernel memory it allows

Glad to see the task_refs patches in particular resubmitted.

This is a long set including some big patches, so it's hard to just
sit down and audit for errors, but looking at before- and after- they
look nice.

Resulting kernel passes ltp stresstests and zseries.

-serge
