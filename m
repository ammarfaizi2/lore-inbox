Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVILDKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVILDKb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 23:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVILDKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 23:10:30 -0400
Received: from dvhart.com ([64.146.134.43]:18049 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751138AbVILDKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 23:10:30 -0400
Date: Sun, 11 Sep 2005 20:10:35 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, David Wilder <wilder@us.ibm.com>
Subject: Re: 2.6.13-mm2
Message-ID: <202900000.1126494635@[10.10.2.4]>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
References: <20050908053042.6e05882f.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the non-fixed version of Ingo's patch is back.

http://test.kernel.org/12554/debug/console.log

Hangs after the cpu cache auto-detect thing again on NUMA-Q.
I thought Dave Wilder debugged and fixed this? Something to do with
restoring the flags on a different CPU to that on which they were saved.



