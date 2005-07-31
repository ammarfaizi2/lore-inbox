Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVGaCBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVGaCBd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 22:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVGaCBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 22:01:33 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10649 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261279AbVGaCBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 22:01:32 -0400
Date: Sat, 30 Jul 2005 19:01:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
Message-Id: <20050730190126.6bec9186.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0507301814540.31359@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
	<20050729152049.4b172d78.pj@sgi.com>
	<Pine.LNX.4.62.0507291746000.8663@graphe.net>
	<20050729230026.1aa27e14.pj@sgi.com>
	<Pine.LNX.4.62.0507301042420.26355@graphe.net>
	<20050730181418.65caed1f.pj@sgi.com>
	<Pine.LNX.4.62.0507301814540.31359@graphe.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> The problem is how to convert them back for display. Match the zones in 
> groups of three to the zones in a node and then print out the node?

What does get_mempolicy(2) do?  I doubt it assumes groups of three.
See further the case for MPOL_BIND, in mm/mempolicy.c:get_zonemask().

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
