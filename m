Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVFULnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFULnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVFULmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:42:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37321 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261282AbVFULmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:42:37 -0400
Date: Tue, 21 Jun 2005 07:42:26 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Greg K-H <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: [PATCH] Add initial implementation of klist helpers.
In-Reply-To: <1119308365601@kroah.com>
Message-ID: <Pine.LNX.4.61.0506210740220.10499@chimarrao.boston.redhat.com>
References: <1119308365601@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Greg KH wrote:

> Internally, that routine takes the klist's lock, decrements the reference
> count of the previous klist_node and increments the count of the next
> klist_node. It then drops the lock and returns.

Sacrificing performance for scalability has never been
the right thing in the past.  Why would it be right now?

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
