Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWGHN66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWGHN66 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWGHN66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:58:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:6369 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964836AbWGHN65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:58:57 -0400
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Introduce list_get() and list_get_tail()
References: <200607080124.21856.dtor@insightbb.com>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2006 15:58:55 +0200
In-Reply-To: <200607080124.21856.dtor@insightbb.com>
Message-ID: <p73wtaonqow.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor@insightbb.com> writes:

> From: Dmitry Torokhov <dtor@mail.ru>
> 
> Add primitives to access first and last elements of a list instead
> of accessng pointers directly.

Wouldn't that be beter named list_first() and list_last() then?
_get is like _do and usually not very descriptive.

-Andi
