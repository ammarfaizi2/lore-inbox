Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbTGDTPx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbTGDTPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:15:52 -0400
Received: from holomorphy.com ([66.224.33.161]:61824 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S266132AbTGDTPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:15:51 -0400
Date: Fri, 4 Jul 2003 12:31:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704193135.GF955@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <Pine.LNX.4.53.0307041139150.24383@montezuma.mastecende.com> <13170000.1057335490@[10.10.2.4]> <20030704183106.GC955@holomorphy.com> <14820000.1057346400@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14820000.1057346400@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> The bitmap is wider than the function wants. The change is fine, despite
>> your abuse of phys_cpu_present_map.

On Fri, Jul 04, 2003 at 12:20:02PM -0700, Martin J. Bligh wrote:
> I'm happy to remove the abuse of phys_cpu_present_map, seeing as we now
> have a reason to do so. That would actually seem a much cleaner solution
> to these problems than creating a whole new data type, which still doesn't
> represent what it claims to

Dirtier, but possibly lower line count.


-- wli
