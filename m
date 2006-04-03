Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWDCOuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWDCOuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWDCOuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:50:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25796 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751634AbWDCOuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:50:18 -0400
Message-ID: <4431360D.1050702@sgi.com>
Date: Mon, 03 Apr 2006 16:49:49 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       bjorn_helgaas@hp.com, cotte@de.ibm.com
Subject: Re: [patch] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <44310B0C.3070203@yahoo.com.au>
In-Reply-To: <44310B0C.3070203@yahoo.com.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Should you recheck to make sure nobody else faulted this in
> before it was relocked? Doesn't seem to matter in this case,
> but it would be more consistent with the other fault handlers.
> 

I'm fine either way. It didn't matter to the case I need it for, but
if you think it would make more sense I am fine with that.

Cheers,
Jes
