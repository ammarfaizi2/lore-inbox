Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbWEJXFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbWEJXFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWEJXFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:05:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23210 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965050AbWEJXFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:05:02 -0400
Date: Wed, 10 May 2006 16:04:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Con Kolivas <kernel@kolivas.org>
cc: linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: cleanup swap unused warning
In-Reply-To: <200605102132.41217.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.64.0605101604330.7472@schroedinger.engr.sgi.com>
References: <200605102132.41217.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Con Kolivas wrote:

> Are there any users of swp_entry_t when CONFIG_SWAP is not defined?

Yes, a migration entry is a form of swap entry.
