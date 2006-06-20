Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWFTI7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWFTI7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWFTI7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:59:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52151 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965224AbWFTI7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:59:21 -0400
Message-ID: <4497B8C5.7000108@de.ibm.com>
Date: Tue, 20 Jun 2006 10:58:45 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: Andi Kleen <ak@suse.de>, Jes Sorensen <jes@sgi.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <p73r71lpa6a.fsf@verdi.suse.de> <20060619224952.GA17685@lnx-holt.americas.sgi.com>
In-Reply-To: <20060619224952.GA17685@lnx-holt.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
> For Carsten's case, how would you propose we handle that?
After previous discussion with Linus, and because I do not
have a good idea how to solve the remaining problems
in a clean way (yet?), please leave my case out for now.
We won't need it anytime soon on 390 as far as I can tell.

Linus Torvalds wrote:
> You _really_ cannot do COW together with "random pfn
> filling".

cheers,
Carsten
