Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUDORwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUDORvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:51:10 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55834 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264370AbUDORuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:50:50 -0400
Date: Thu, 15 Apr 2004 18:50:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <178970000.1082049291@flay>
Message-ID: <Pine.LNX.4.44.0404151842530.9612-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Martin J. Bligh wrote:
> 
> I still think my list-of-lists patch fixes the original problem, and is
> simpler ... I'll try to get it updated, and sent out.

Please do, I never saw it before.

Though I have to admit I'm sceptical: prio_tree appears to be well
designed for the issue in question, list-of-lists sounds, well,
no offence, but a bit of a hack.

But we may well have overlooked the overhead of prio_tree's
complexity relative to list, and need to reconsider options.

Hugh

