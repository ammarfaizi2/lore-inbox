Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVIYKF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVIYKF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 06:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVIYKF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 06:05:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28121 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751050AbVIYKF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 06:05:29 -0400
Date: Sun, 25 Sep 2005 11:05:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_IA32
Message-ID: <20050925100525.GA14741@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <4335DD14.7090909@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4335DD14.7090909@didntduck.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 07:11:16PM -0400, Brian Gerst wrote:
> Add CONFIG_IA32 for i386.  This allows selecting options that only apply 
> to 32-bit systems.
> 
> (X86 && !X86_64) becomes IA32
> (X86 ||  X86_64) becomes X86

Please call it X86_32 or I386, to match the terminology we use everywhere.
I386 would match the uname, and X86_32 would be the logical countepart
to X86_64.

