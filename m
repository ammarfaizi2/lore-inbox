Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270877AbUJVJxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270877AbUJVJxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270914AbUJVJxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:53:17 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:51872 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S270877AbUJVJxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:53:15 -0400
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       jeremy@sgi.com
Subject: Re: [PATCH] use mmiowb in qla1280.c
References: <200410211613.19601.jbarnes@engr.sgi.com>
	<200410211617.14809.jbarnes@engr.sgi.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 22 Oct 2004 05:53:13 -0400
In-Reply-To: <200410211617.14809.jbarnes@engr.sgi.com>
Message-ID: <yq03c07nkom.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jesse" == Jesse Barnes <jbarnes@engr.sgi.com> writes:

Jesse> There are a few spots in qla1280.c that don't need a full PCI
Jesse> write flush to the device, but rather a simple write ordering
Jesse> guarantee.  This patch changes some of the PIO reads that cause
Jesse> write flushes into mmiowb calls instead, which is a lighter
Jesse> weight way of ensuring ordering.

Jesse> Jes and James, can you ack this and/or push it in via the SCSI
Jesse> BK tree?

ACK!

James will you push this one?

Cheers,
Jes
