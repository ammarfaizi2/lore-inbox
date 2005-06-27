Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVF0Ovg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVF0Ovg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVF0Oui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:50:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14825 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262135AbVF0NIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:08:36 -0400
Date: Mon, 27 Jun 2005 09:08:14 -0400 (EDT)
From: Rik Van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Martin Schlemmer <azarah@nosferatu.za.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Song Jiang <sjiang@lanl.gov>
Subject: Re: [PATCH] 2/2 swap token tuning
In-Reply-To: <1119877465.25717.4.camel@lycan.lan>
Message-ID: <Pine.LNX.4.61.0506270907110.18834@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0506261827500.18834@chimarrao.boston.redhat.com>
  <Pine.LNX.4.61.0506261835000.18834@chimarrao.boston.redhat.com>
 <1119877465.25717.4.camel@lycan.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Martin Schlemmer wrote:

> -+				sem_is_read_locked(mm->mmap_sem))
> +                               sem_is_read_locked(&mm->mmap_sem))

Yes, you are right.  I sent out the patch before the weekend
was over, before having tested it locally ;)

My compile hit the error a few minutes after I sent out the
mail, doh ;)

Andrew has a fixed version of the patch already.

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
