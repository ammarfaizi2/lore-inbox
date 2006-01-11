Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWAKVvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWAKVvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWAKVvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:51:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:21379 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750952AbWAKVvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:51:06 -0500
Date: Wed, 11 Jan 2006 13:50:41 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Adrian Bunk <bunk@stusta.de>
cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] mm/rmap.c: don't forget to include module.h
In-Reply-To: <20060111214212.GF29663@stusta.de>
Message-ID: <Pine.LNX.4.62.0601111350250.25126@schroedinger.engr.sgi.com>
References: <20060111042135.24faf878.akpm@osdl.org> <20060111165758.GH8686@mipter.zuzino.mipt.ru>
 <20060111214212.GF29663@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Adrian Bunk wrote:

> There's no need for an #ifdef.

Correct. Just put the #include back.

