Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUJLPww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUJLPww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUJLPwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:52:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54967 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265910AbUJLPwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:52:43 -0400
Date: Tue, 12 Oct 2004 11:52:38 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Lameter <clameter@sgi.com>
cc: linux-kernel@vger.kernel.org, <nickpiggin@yahoo.com.au>,
       <linux-mm@kvack.org>
Subject: Re: NUMA: Patch for node based swapping
In-Reply-To: <Pine.LNX.4.58.0410120838570.12195@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0410121151220.13693-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Christoph Lameter wrote:

> Any other suggestions?

Since this is meant as a stop gap patch, waiting for a real
solution, and is only relevant for big (and rare) systems,
it would be an idea to at least leave it off by default.

I think it would be safe to assume that a $100k system has
a system administrator looking after it, while a $5k AMD64
whitebox might not have somebody watching its performance.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

