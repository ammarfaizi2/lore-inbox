Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVGZVAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVGZVAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVGZVAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:00:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262045AbVGZVAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:00:35 -0400
Date: Tue, 26 Jul 2005 16:59:57 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Memory pressure handling with iSCSI
In-Reply-To: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0507261659250.1786@chimarrao.boston.redhat.com>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.61.0507261659252.1786@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005, Badari Pulavarty wrote:

> After KS & OLS discussions about memory pressure, I wanted to re-do
> iSCSI testing with "dd"s to see if we are throttling writes.  

Could you also try with shared writable mmap, to see if that
works ok or triggers a deadlock ?

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
