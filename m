Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265482AbUFVUML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbUFVUML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUFVUKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:10:39 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:2909 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265132AbUFVUCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:02:12 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on using MSI in PCI driver
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E5024057E5196@orsmsx404.amr.corp.intel.com>
	<20040622195151.GA8809@infradead.org>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 22 Jun 2004 12:55:13 -0700
In-Reply-To: <20040622195151.GA8809@infradead.org> (Christoph Hellwig's
 message of "Tue, 22 Jun 2004 20:51:51 +0100")
Message-ID: <52d63rmkpq.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 19:55:13.0569 (UTC) FILETIME=[D506F910:01C45892]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Christoph> Why do you think you want "failure" in that string?
    Christoph> It's a name that can be used to easily identify the
    Christoph> MMIO region, and your sentence is a) too long and b)
    Christoph> doesn't make sense (at least to me, maybe I'm missing
    Christoph> something important).

Agreed (and I think Long agrees now too).

    Christoph> Why not just "MSI-X PBA"?

Just to be clear ... it's not actually the PBA, so I don't think
that's a good idea.  I believe my suggestion of "MSI-X vector table,"
which Long accepted, is the right name.

 - Roland
