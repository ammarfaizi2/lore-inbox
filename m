Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVIHRKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVIHRKD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 13:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVIHRKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 13:10:03 -0400
Received: from S01060013104bd78e.vc.shawcable.net ([24.85.145.160]:18151 "EHLO
	r3000.fsmlabs.com") by vger.kernel.org with ESMTP id S964920AbVIHRKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 13:10:01 -0400
Date: Thu, 8 Sep 2005 10:09:56 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jan Beulich <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] re-export genapic on i386
In-Reply-To: <4320793602000078000244D9@emea1-mh.id2.novell.com>
Message-ID: <Pine.LNX.4.63.0509081008120.8052@r3000.fsmlabs.com>
References: <4320793602000078000244D9@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005, Jan Beulich wrote:

> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> A change not too long ago made i386's genapic symbol no longer be
> exported,
> and thus certain low-level functions no longer be usable. Since
> close-to-
> the-hardware code may still be modular, this rectifies the situation.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>

Since there are no in-kernel tree users of this, i suggest that you keep 
it as a seperate patch, and generally for all exports that you may require 
for your external work. Then when/if your work gets merged you can submit 
it.

Thanks,
	Zwane

