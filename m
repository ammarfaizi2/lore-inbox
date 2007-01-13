Return-Path: <linux-kernel-owner+w=401wt.eu-S1161193AbXAMBLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbXAMBLb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 20:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161195AbXAMBLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 20:11:31 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50781 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161193AbXAMBLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 20:11:30 -0500
Date: Fri, 12 Jan 2007 17:11:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>, a.p.zijlstra@chello.nl
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
Message-Id: <20070112171116.a8f62ecb.akpm@osdl.org>
In-Reply-To: <20070113010039.GA8465@localhost.localdomain>
References: <20070112160104.GA5766@localhost.localdomain>
	<Pine.LNX.4.64.0701121137430.2306@schroedinger.engr.sgi.com>
	<20070112214021.GA4300@localhost.localdomain>
	<Pine.LNX.4.64.0701121341320.3087@schroedinger.engr.sgi.com>
	<20070113010039.GA8465@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 17:00:39 -0800
Ravikiran G Thirumalai <kiran@scalex86.org> wrote:

> But is
> lru_lock an issue is another question.

I doubt it, although there might be changes we can make in there to
work around it.

<mentions PAGEVEC_SIZE again>
