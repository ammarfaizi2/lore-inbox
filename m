Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUH2Gjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUH2Gjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 02:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUH2Gjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 02:39:43 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:32966 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266129AbUH2Gjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 02:39:41 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Patrick Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code 
In-reply-to: Your message of "Fri, 27 Aug 2004 17:21:31 +0100."
             <20040827172131.A473@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Aug 2004 16:39:34 +1000
Message-ID: <28819.1093761574@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 17:21:31 +0100, 
Christoph Hellwig <hch@infradead.org> wrote:
>all files: lots of missing statics, try running
>http://samba.org/ftp/unpacked/junkcode/findstatic.pl over the compiled code.

ftp://ftp.ocs.com.au/pub/namespace.pl does a more rigorous check for
symbols that can be static.  namespace.pl knows about the special
kernel symbols, linkage and EXPORT_SYMBOL().

