Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTLQLHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTLQLHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:07:07 -0500
Received: from holomorphy.com ([199.26.172.102]:46992 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264331AbTLQLHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:07:05 -0500
Date: Wed, 17 Dec 2003 03:06:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, kernel@kolivas.org,
       chris@cvine.freeserve.co.uk, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031217110648.GB31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, kernel@kolivas.org,
	chris@cvine.freeserve.co.uk, linux-kernel@vger.kernel.org,
	mbligh@aracnet.com
References: <20031216112307.GA5041@k3.hellgate.ch> <Pine.LNX.4.44.0312161126520.19925-100000@chimarrao.boston.redhat.com> <20031217110336.GA5615@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217110336.GA5615@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003 11:29:50 -0500, Rik van Riel wrote:
>> Could you try "echo 0 > /proc/sys/vm/lower_zone_protection" ?

On Wed, Dec 17, 2003 at 12:03:37PM +0100, Roger Luethi wrote:
> Defaults to 0 anyway, doesn't it? Turning it _on_ seems to slow
> benchmarks down somewhat (< 5%). In one of ten runs, though, the efax
> test stopped doing anything for ten minutes -- no disk activity, no
> progress whatsoever.

Sorry about that, that got brought up elsewhere but not propagated out
to lkml. Hearing more about the various degradations you've identified
would be helpful.


-- wli
