Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVKKDjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVKKDjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVKKDjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:39:24 -0500
Received: from ns.suse.de ([195.135.220.2]:43467 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932351AbVKKDjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:39:24 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 18/39] NLKD/x86-64 - INT1/INT3 handling changes
Date: Fri, 11 Nov 2005 04:39:05 +0100
User-Agent: KMail/1.8
Cc: "Jan Beulich" <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <43720DAE.76F0.0078.0@novell.com> <200511101525.06063.ak@suse.de> <43736E8D.76F0.0078.0@novell.com>
In-Reply-To: <43736E8D.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511110439.05913.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 November 2005 16:00, Jan Beulich wrote:

> Since the exception stack size doesn't get set to other than 4k, this
> isn't by itself wrong (the NLKD patch later conditionally sets this to
> more than 4k). The problem, as said in the patch, is that pda.h cannot
> include processor.h, and I see no solution for that (other than breaking
> up processor.h).

You mean for the exception stack size defines? Feel free to put them into
a different header then. processor.h has too much stuff anyways.

-Andi
