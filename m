Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264580AbSIVWjM>; Sun, 22 Sep 2002 18:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264583AbSIVWjM>; Sun, 22 Sep 2002 18:39:12 -0400
Received: from holomorphy.com ([66.224.33.161]:56722 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264580AbSIVWjL>;
	Sun, 22 Sep 2002 18:39:11 -0400
Date: Sun, 22 Sep 2002 15:36:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <20020922223630.GG25605@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <78206124.1032689516@[10.10.2.3]> <85905225.1032697215@[10.10.2.3]> <200209222359.16296.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200209222359.16296.efocht@ess.nec.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 11:59:16PM +0200, Erich Focht wrote:
> A bit more difficult is tuning the scheduler parameters which can
> be done pretty simply by changing the __node_distance matrix. A first
> attempt could be: 10 on the diagonal, 100 off-diagonal. This leads to
> larger delays when stealing from a remote node.

This is not entirely reflective of our architecture. Node-to-node
latencies vary as well. Some notion of whether communication must cross
a lash at the very least should be present.


Cheers,
Bill
