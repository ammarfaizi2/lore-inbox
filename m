Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbUKHRHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUKHRHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUKHRHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:07:08 -0500
Received: from cantor.suse.de ([195.135.220.2]:20930 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261930AbUKHQ0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:26:16 -0500
Date: Mon, 8 Nov 2004 17:19:35 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108161935.GC2456@wotan.suse.de>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de> <20041108153436.GB9783@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108153436.GB9783@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rethinking it, I don't even understand the sprintf example in your 
> changelog entry - shouldn't an inclusion of kernel.h always get it 
> right?

Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str) transparently.

-Andi
