Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVAXVdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVAXVdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVAXVbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:31:48 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:52377
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261620AbVAXU1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:27:20 -0500
Date: Mon, 24 Jan 2005 12:23:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, hugh@veritas.com, linux-ia64@vger.kernel.org,
       torvalds@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Extend clear_page by an order parameter
Message-Id: <20050124122350.1142ee81.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0501240835041.15963@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501041512450.1536@schroedinger.engr.sgi.com>
	<Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
	<20050108135636.6796419a.davem@davemloft.net>
	<Pine.LNX.4.58.0501211210220.25925@schroedinger.engr.sgi.com>
	<20050122234517.376ef3f8.akpm@osdl.org>
	<Pine.LNX.4.58.0501240835041.15963@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 08:37:15 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> Then it may also be better to pass the page struct to clear_pages
> instead of a memory address.

What is more generally available at the call sites at this time?
Consider both HIGHMEM and non-HIGHMEM setups in your estimation
please :-)

