Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVDZTsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVDZTsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 15:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVDZTsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 15:48:53 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:47819 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261753AbVDZTsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 15:48:52 -0400
X-ORBL: [67.124.119.21]
Date: Tue, 26 Apr 2005 12:48:41 -0700
From: Chris Wedgwood <cw@f00f.org>
To: prasanna@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't oops when unregistering unknown kprobes
Message-ID: <20050426194841.GA2955@taniwha.stupidest.org>
References: <20050426162203.GE27406@gilgamesh.home.res>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426162203.GE27406@gilgamesh.home.res>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 06:22:03PM +0200, Frederik Deweerdt wrote:

> Here's a patch that handles gracefully attempts to unregister
> unregistered kprobes (ie. a warning message instead of an oops).
> Patch is against 2.6.12-rc3

Why not -EINVAL instead of the printk?
