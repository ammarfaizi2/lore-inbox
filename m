Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTD2WaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTD2WaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:30:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21701 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261773AbTD2WaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:30:09 -0400
Date: Tue, 29 Apr 2003 23:42:28 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: alan@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Message-ID: <20030429224228.GQ10374@parcelfarce.linux.theplanet.co.uk>
References: <200304292215.20590.devenyga@mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304292215.20590.devenyga@mcmaster.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 10:15:20PM +0000, Gabriel Devenyi wrote:
> This patch applies to 2.5.68. It converts all the remaining error returns to 
> the new return -E form, this is in the KernelJanitor TODO list.
> 
> http://muss.mcmaster.ca/~devenyga/patch-linux-2.5.68-return-errors.patch
> 
> Please CC me with any discussion since I do not subscribe to lkml

Have you tried to compile the patched kernel?

Patch is bogus - most of the changes are s/return ERR_PTR(foo)/return foo/
with neither explanation nor change of function prototype not change of
other exits from these functions.

WTF was it intended to do?
