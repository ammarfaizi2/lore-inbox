Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162152AbWKPBW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162152AbWKPBW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162153AbWKPBW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:22:58 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:429 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1162152AbWKPBW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:22:58 -0500
Date: Thu, 16 Nov 2006 10:22:05 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have no memory
Cc: mbligh@mbligh.org, krafft@de.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061116095945.e6ad4440.kamezawa.hiroyu@jp.fujitsu.com>
References: <Pine.LNX.4.64.0611151450550.23477@schroedinger.engr.sgi.com> <20061116095945.e6ad4440.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20061116101358.2CB6.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.27 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I hear some vender's machine has this configuration. (ia64, maybe SGI or HP)
> 
> Node0: CPUx0 + XXXGb memory
> Node1: CPUx2 + 16MB memory
> Node2: CPUx2 + 16MB memory
> 
> memory of Node1 and Node2 is tirmmed at boot by GRANULE alignment.
> Then, final view is
> Node0 : memory-only-node
> Node1 : cpu-only-node
> Node2 : cpu-only-node.

IIRC, this is HP box. It is using memory interleave among nodes.

Bye.
-- 
Yasunori Goto 


