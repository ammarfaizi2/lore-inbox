Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbTGDSRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 14:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266093AbTGDSRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 14:17:04 -0400
Received: from holomorphy.com ([66.224.33.161]:31104 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266091AbTGDSQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 14:16:58 -0400
Date: Fri, 4 Jul 2003 11:32:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704183243.GD955@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <Pine.LNX.4.53.0307041139150.24383@montezuma.mastecende.com> <13170000.1057335490@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13170000.1057335490@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 09:18:12AM -0700, Martin J. Bligh wrote:
> Ugh, are you saying the cpumask stuff shrinks masks to < 32 bits if
> NR_CPUS is low enough? If so, I can see more point to the patch, but
> it still seems like violent overkill. Stopping it doing that would
> probably fix it ... I can't imagine it buys you much.

Step off it. This is not overkill. This is correct.


-- wli
