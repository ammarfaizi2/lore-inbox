Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266830AbUHORrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266830AbUHORrW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUHORrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:47:22 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:7173 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266830AbUHORrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:47:20 -0400
Date: Sun, 15 Aug 2004 18:47:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: module parameters and 2.6 macros
Message-ID: <20040815184718.A3350@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
References: <20040815174108.14463.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040815174108.14463.qmail@web14929.mail.yahoo.com>; from jonsmirl@yahoo.com on Sun, Aug 15, 2004 at 10:41:08AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 10:41:08AM -0700, Jon Smirl wrote:
> Is there some way to avoid two sets of parsing code with the 2.6 module
> parameter macros?

Yes, if you use module_param{,_named} and a paramter 'foo' you can use
foo=1 at modprobe time and modulename.foo=1 at the kernel command line

