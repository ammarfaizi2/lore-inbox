Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUIMOmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUIMOmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUIMOmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:42:09 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:28170 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267615AbUIMOiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:38:11 -0400
Date: Mon, 13 Sep 2004 15:38:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Constantine Gavrilov <constg@qlusters.com>
Cc: bugs@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron machines
Message-ID: <20040913153803.A27282@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Constantine Gavrilov <constg@qlusters.com>, bugs@x86-64.org,
	linux-kernel@vger.kernel.org
References: <4145A8E1.8010409@qlusters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4145A8E1.8010409@qlusters.com>; from constg@qlusters.com on Mon, Sep 13, 2004 at 05:04:17PM +0300
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 05:04:17PM +0300, Constantine Gavrilov wrote:
> Hello:
> 
> We have a piece of kernel code that calls some system calls in kernel 
> context (

Which you shouldn't do in the first place.

