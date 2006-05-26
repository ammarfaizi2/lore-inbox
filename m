Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWEZT7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWEZT7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWEZT7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:59:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:49844 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751410AbWEZT7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:59:46 -0400
Date: Fri, 26 May 2006 12:59:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] swapless page migration: fix fork corruption
In-Reply-To: <Pine.LNX.4.64.0605261923430.24818@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0605261258590.837@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0605261923430.24818@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006, Hugh Dickins wrote:

> The protection in copy_one_pte looks very convincing, until at last you
> realize that the second arg to make_migration_entry is a boolean "write",
> and SWP_MIGRATION_READ is 30.

Sigh.

Acked-by: Christoph Lameter <clameter@sgi.com>
