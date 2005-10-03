Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVJCBSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVJCBSV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 21:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVJCBSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 21:18:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43197 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932104AbVJCBSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 21:18:21 -0400
Date: Sun, 2 Oct 2005 21:18:16 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <20051003011041.GN6290@lkcl.net>
Message-ID: <Pine.LNX.4.63.0510022114080.27456@cuia.boston.redhat.com>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
 <20051002230545.GI6290@lkcl.net> <54300000.1128297891@[10.10.2.4]>
 <20051003011041.GN6290@lkcl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Luke Kenneth Casson Leighton wrote:

>  well... actually, as it turns out, the l4linux and l4ka people have
>  already done most of the work!!

And I am sure they have reasons for not submitting their
changes to the linux-kernel mailing list.  They probably
know something we (including you) don't know.

Switching out the low level infrastructure does NOT help
with scalability.  The only way to make the kernel more
parallelizable is by changing the high level code, ie.
Linux itself.

Adding a microkernel under Linux is not going to help
with anything you mentioned so far.

-- 
All Rights Reversed
