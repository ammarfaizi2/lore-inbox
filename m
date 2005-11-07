Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVKGOGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVKGOGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVKGOGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:06:34 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:30440 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964822AbVKGOGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:06:34 -0500
Subject: Re: [patch 02/02] Debug option to write-protect rodata: the write
	protect logic and config option
From: Josh Boyer <jdub@us.ibm.com>
To: arjan@infradead.org
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
In-Reply-To: <20051107105807.GB6531@infradead.org>
References: <20051107105624.GA6531@infradead.org>
	 <20051107105807.GB6531@infradead.org>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 08:06:14 -0600
Message-Id: <1131372374.23658.1.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 10:58 +0000, arjan@infradead.org wrote:
> Hi,
> 
> I've been working on a patch that turns the kernel's .rodata section to be
> actually read only, eg any write attempts to it cause a segmentation fault.
> 
> This patch introduces the actual debug option to catch any writes to rodata

Why a debug option?  From what I can tell, it doesn't impact runtime
performance much and it provides good protection.  Any reason not to
make it an always-on feature?

josh

