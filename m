Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVJaTFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVJaTFO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVJaTFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:05:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:10954 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932494AbVJaTFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:05:12 -0500
Date: Mon, 31 Oct 2005 11:05:04 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/5] atomic: atomic_inc_not_zero
In-Reply-To: <4364178E.8040502@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0510311104190.5528@schroedinger.engr.sgi.com>
References: <436416AD.3050709@yahoo.com.au> <4364171C.7020103@yahoo.com.au>
 <43641755.5010004@yahoo.com.au> <4364178E.8040502@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe it would be best to put a definition of atomic_inc_zero into 
asm-generic? Its the same for all arches that support cmpxchg.

