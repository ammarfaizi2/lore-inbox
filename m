Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266092AbTGDSP2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 14:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbTGDSP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 14:15:28 -0400
Received: from holomorphy.com ([66.224.33.161]:27776 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266086AbTGDSPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 14:15:23 -0400
Date: Fri, 4 Jul 2003 11:31:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704183106.GC955@holomorphy.com>
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
> Yeah, things taking logical apicids, and turning them into cpu numbers
> presumably shouldn't have to touch that.

The bitmap is wider than the function wants. The change is fine, despite
your abuse of phys_cpu_present_map.


-- wli
