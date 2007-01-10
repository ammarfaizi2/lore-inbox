Return-Path: <linux-kernel-owner+w=401wt.eu-S965290AbXAJXEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbXAJXEj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbXAJXEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:04:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36528 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965290AbXAJXEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:04:38 -0500
Date: Wed, 10 Jan 2007 15:04:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Chinner <dgc@sgi.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
In-Reply-To: <20070110223731.GC44411608@melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com>
References: <20070110223731.GC44411608@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, David Chinner wrote:

> The performance and smoothness is fully restored on 2.6.20-rc3
> by setting dirty_ratio down to 10 (from the default 40), so
> something in the VM is not working as well as it used to....

dirty_background_ratio is left as is at 10? So you gain performance
by switching off background writes via pdflush?
