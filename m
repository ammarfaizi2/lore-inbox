Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVIGO2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVIGO2r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVIGO2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:28:46 -0400
Received: from dvhart.com ([64.146.134.43]:59017 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932142AbVIGO2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:28:46 -0400
Date: Wed, 07 Sep 2005 07:28:44 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Christoph Lameter <clameter@engr.sgi.com>, torvalds@osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, hugh@veritas.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Hugh's alternate page fault scalability approach on 512p Altix
Message-ID: <20660000.1126103324@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.62.0509061129380.16939@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0509061129380.16939@schroedinger.engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anticipatory prefaulting raises the highest fault rate obtainable three-fold
> through gang scheduling faults but may allocate some pages to a task that are
> not needed.

IIRC that costed more than it saved, at least for forky workloads like a
kernel compile - extra cost in zap_pte_range etc. If things have changed
substantially in that path, I guess we could run the numbers again - has
been a couple of years.

M.

