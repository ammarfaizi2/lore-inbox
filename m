Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVEPXP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVEPXP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 19:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVEPXP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 19:15:28 -0400
Received: from dvhart.com ([64.146.134.43]:3746 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261980AbVEPXPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 19:15:11 -0400
Date: Mon, 16 May 2005 16:15:07 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
Message-ID: <792700000.1116285307@flay>
In-Reply-To: <Pine.LNX.4.62.0505161602460.20110@graphe.net>
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There was a prior discussion with the ppc64 folks about the way that 
> asm-generic/topology.h was included only for CONFIG_NUMA. I thought that 
> was fixed?
> 
> asm-generic/topology.h must also be included if CONFIG_NUMA is not set 
> inorder to provide the fall back pcibus_to_node function.
> 
> patch follows. Cannot test since I do not have a ppc64.

OK, I queued up a test. Ping me if you don't get an answer by tommorow ...

M.


