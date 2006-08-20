Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWHTQF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWHTQF0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWHTQFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:05:25 -0400
Received: from mail.enyo.de ([212.9.189.167]:18183 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1750825AbWHTQFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:05:25 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
References: <20060820003840.GA17249@openwall.com>
Date: Sun, 20 Aug 2006 18:04:51 +0200
In-Reply-To: <20060820003840.GA17249@openwall.com> (Solar Designer's message
	of "Sun, 20 Aug 2006 04:38:40 +0400")
Message-ID: <87veonqtp8.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Solar Designer:

> Opinions are welcome.

Distributors have already begun to patch userland to check for error
returns.  Arguably, this is the correct approach, but I fear it takes
far too long to fix all callers.
