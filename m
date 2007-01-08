Return-Path: <linux-kernel-owner+w=401wt.eu-S965235AbXAHSyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbXAHSyR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 13:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbXAHSyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 13:54:17 -0500
Received: from smtp.nokia.com ([131.228.20.172]:58430 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965235AbXAHSyQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 13:54:16 -0500
Subject: Re: kallsyms_lookup export in -mm
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20070108103417.5bb5af26.akpm@osdl.org>
References: <20070108133036.GA18681@infradead.org>
	 <20070108103417.5bb5af26.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jan 2007 20:53:35 +0200
Message-Id: <1168282415.3873.4.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 08 Jan 2007 18:53:35.0531 (UTC) FILETIME=[4CFEA7B0:01C73356]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 10:34 -0800, Andrew Morton wrote:
> On Mon, 8 Jan 2007 13:30:36 +0000
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > This beast definitly shouldn't be exported.  drivers/mtd/ubi/debug.c
> > should probably be just removed instead - it's an utter mess anyway.
> 
> I think that's happening.  Partially, at least.

I will remove kallsyms_lookup exporting, just wait a bit - I have HDD
crash :-(

About utter mess - I do not agree, but I would carefully listen to
arguments and of course would fix the mess.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)

