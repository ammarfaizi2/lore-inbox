Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVFVDhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVFVDhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 23:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVFVDhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 23:37:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27076 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262561AbVFVDfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 23:35:18 -0400
Date: Tue, 21 Jun 2005 23:35:10 -0400 (EDT)
From: Rik Van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: OCFS (was Re: -mm -> 2.6.13 merge status)
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0506212334010.4159@chimarrao.boston.redhat.com>
References: <20050620235458.5b437274.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Andrew Morton wrote:

> git-ocfs
> 
>     The OCFS2 filesystem.  OK by me, although I'm not sure it's had enough
>     review.

The only problem I can see with this is that people will want
to use OCFS together with CLVM, and both use a different cluster
infrastructure.

IMHO it would be good if they both used the same underlying
cluster infrastructure...

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
