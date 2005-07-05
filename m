Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVGEWwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVGEWwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVGEWwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:52:16 -0400
Received: from graphe.net ([209.204.138.32]:60376 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261986AbVGEWwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:52:09 -0400
Date: Tue, 5 Jul 2005 15:51:58 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Anton Blanchard <anton@samba.org>
cc: akpm@osdl.org, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: slab not freeing with current -git
In-Reply-To: <20050705224528.GJ12786@krispykreme>
Message-ID: <Pine.LNX.4.62.0507051550120.1806@graphe.net>
References: <20050705224528.GJ12786@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Anton Blanchard wrote:

> FYI the kernel has NUMA enabled but the machine has only 1 NUMA node.

Ummm. But it has multiple memory nodes? We ran into trouble with the funky
memory arrangement before.

