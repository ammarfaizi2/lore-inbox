Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbULPTSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbULPTSR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbULPTQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:16:29 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:7813 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261991AbULPTPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:15:05 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz, davidm@hpl.hp.com
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
Date: Thu, 16 Dec 2004 11:13:57 -0800
User-Agent: KMail/1.7.1
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, willy@debian.org
References: <200412160850.20223.jbarnes@engr.sgi.com> <200412161107.57457.jbarnes@engr.sgi.com> <16833.56805.348569.77624@napali.hpl.hp.com>
In-Reply-To: <16833.56805.348569.77624@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412161113.58224.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 16, 2004 11:11 am, David Mosberger wrote:
> >>>>> On Thu, 16 Dec 2004 11:07:56 -0800, Jesse Barnes
> >>>>> <jbarnes@engr.sgi.com> said:
>
>   Jesse> On Thursday, December 16, 2004 10:56 am, Jesse Barnes wrote:
>
>   Jesse> Maybe this is a little better?
>
> The ia64_pci_legacy_{read,write}() functions definitely look much
> better, except I don't think you need any casts in the outX() calls.

You're right, I've removed them.

Thanks,
Jesse
