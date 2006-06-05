Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751397AbWFEUHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWFEUHr (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWFEUHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:07:47 -0400
Received: from smtp-out.google.com ([216.239.45.12]:11675 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751397AbWFEUHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:07:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=m2U/rZUtNfbTrGLDbfibcfQpbD4Eos0XD1JAg1MO/LL9vGoAaEufjl7oHhMYubgFg
	gdYSRf5PhvZWoNgNGQH+g==
Message-ID: <44848EE6.9070901@google.com>
Date: Mon, 05 Jun 2006 13:07:02 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Christoph Lameter <clameter@sgi.com>,
        "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, ak@suse.de,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org> <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org> <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com> <44848DD2.7010506@shadowen.org>
In-Reply-To: <44848DD2.7010506@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I took the swapless-pm-add-r-w-migration-entries.patch and -fix-2.patch
> as a single patch and didn't test the ----'d level.  It worked anywhere
> I tested up to and including the last one marked GOOD above.  Anywhere
> below that was a mess.  Backing out those two patches (and a bunch of
> dependant ones) seemed to make the problems we get very different, and
> if Martin is right the same as problems we are seeing on other
> architectures.  So I am leaning to the feeling that this part of -mm is
> introducing a problem.

I'm not convinced this is all the same problem. I think we have at least
2 bugs, personally ... but possibly a run across everything with
CONFIG_MIGRATION off would be helpful if you could do that ?
Your beer-owed tab seems to be growing distressingly large though.

Thanks,

M.
