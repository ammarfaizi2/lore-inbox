Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWBZUEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWBZUEV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWBZUEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:04:21 -0500
Received: from kanga.kvack.org ([66.96.29.28]:20435 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751398AbWBZUEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:04:20 -0500
Date: Sun, 26 Feb 2006 15:56:27 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOM-killer too aggressive?
Message-ID: <20060226215627.GB4979@dmt.cnet>
References: <5KvnZ-4uN-27@gated-at.bofh.it> <4401F5E3.3090003@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4401F5E3.3090003@shaw.ca>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 12:39:31PM -0600, Robert Hancock wrote:
> Chuck Ebbert wrote:
> >DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
> >present:15728kB pages_scanned:0 all_unreclaimable? yes
> 
> I think the big question is who used up all the DMA zone.. Surely not 
> the floppy driver..

The kernel text and data? "readelf -S vmlinux" output would be useful.

