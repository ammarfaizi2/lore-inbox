Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUFPUq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUFPUq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbUFPUq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:46:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12932 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264782AbUFPUq1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:46:27 -0400
Date: Wed, 16 Jun 2004 10:57:22 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nuno Monteiro <nuno@itsari.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4] build error with latest BK
Message-ID: <20040616135722.GA2056@logos.cnet>
References: <40CFB2A1.8070104@yahoo.com.au> <20040615164848.GA8276@hobbes.itsari.int> <3473.1087374022@redhat.com> <40D00828.8020303@yahoo.com.au> <16592.3188.448186.438659@alkaid.it.uu.se> <40D00D1F.8070109@yahoo.com.au> <20040616134036.GA2969@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616134036.GA2969@hobbes.itsari.int>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 02:40:36PM +0100, Nuno Monteiro wrote:
> On 2004.06.16 10:04, Nick Piggin wrote:
> > Just simply replace put_task_struct with free_task_struct.
> 
> Like this, maybe? It applies on top of what's currently in BK -- it fixed 
> it for me, compiled and boot tested, running for the last 20 minutes. 
> Also, linux/mm.h is needed because of free_pages().

Ok, applied, thanks everyone. Should be releasing -pre6 in a few moments with 
this.
