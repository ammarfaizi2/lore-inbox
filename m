Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWEULGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWEULGO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 07:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWEULGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 07:06:14 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:46767 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932393AbWEULGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 07:06:12 -0400
Date: Sun, 21 May 2006 04:06:09 -0700
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mm-commits@vger.kernel.org
Subject: Re: + x86-move-vsyscall-page-out-of-fixmap-above-stack-tidy.patch added to -mm tree
Message-ID: <20060521110609.GA8322@taniwha.stupidest.org>
References: <200605210951.k4L9pwHq023019@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605210951.k4L9pwHq023019@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 02:51:54AM -0700, akpm@osdl.org wrote:

> -	if ((ret = insert_vm_struct(mm, vma))) {
> +	ret = insert_vm_struct(mm, vma);
> +	if (ret) {

Urgh.

It's not really any cleaner/clearer so why do that?
