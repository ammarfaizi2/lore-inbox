Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266891AbUH2HWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266891AbUH2HWr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 03:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266831AbUH2HWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 03:22:47 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:13252 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S264256AbUH2HWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 03:22:44 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christoph Hellwig <hch@infradead.org>, Patrick Gefre <pfg@sgi.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Latest Altix I/O code reorganization code 
In-reply-to: Your message of "Sun, 29 Aug 2004 09:16:35 +0200."
             <20040829071635.GB7325@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 29 Aug 2004 17:22:32 +1000
Message-ID: <30024.1093764152@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 09:16:35 +0200, 
Sam Ravnborg <sam@ravnborg.org> wrote:
>On Sun, Aug 29, 2004 at 04:39:34PM +1000, Keith Owens wrote:
>> On Fri, 27 Aug 2004 17:21:31 +0100, 
>> Christoph Hellwig <hch@infradead.org> wrote:
>> >all files: lots of missing statics, try running
>> >http://samba.org/ftp/unpacked/junkcode/findstatic.pl over the compiled code.
>> 
>> ftp://ftp.ocs.com.au/pub/namespace.pl does a more rigorous check for
>> symbols that can be static.  namespace.pl knows about the special
>> kernel symbols, linkage and EXPORT_SYMBOL().
>
>Should we add it to the support scripts in the kernel?
>Something like: 
>
>make checknamespace

Funny about that ... I was making a patch to send to you and akpm when
your mail arrived.

