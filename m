Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbUKDOMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUKDOMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbUKDOMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:12:41 -0500
Received: from sd291.sivit.org ([194.146.225.122]:33248 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262228AbUKDOJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:09:24 -0500
Date: Thu, 4 Nov 2004 15:09:35 +0100
From: Stelian Pop <stelian@popies.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/12] meye: the driver is no longer experimental and depends on PCI
Message-ID: <20041104140934.GZ3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Arjan van de Ven <arjan@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr> <20041104111613.GM3472@crusoe.alcove-fr> <20041104114126.GA31736@infradead.org> <20041104114904.GV3472@crusoe.alcove-fr> <1099570980.16640.6.camel@laptop.fenrus.org> <20041104123210.GW3472@crusoe.alcove-fr> <1099574162.16640.9.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099574162.16640.9.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 02:16:02PM +0100, Arjan van de Ven wrote:

> 
> > I thought that CONFIG_HIGHMEM64G is not cost-free and thus must
> > be enabled only when needed...
> 
> having multiple kernels also isn't free... and there's a milion
> different config options that cost/gain performance ;)

What about backward compatibility ? If I understand the PAE help text
correctly, a PAE enabled kernel will not boot on a processor which
doesn't support PAE, like my Crusoe:

processor	: 0
vendor_id	: GenuineTMx86
cpu family	: 6
model		: 4
model name	: Transmeta(tm) Crusoe(tm) Processor TM5600
stepping	: 3
cpu MHz		: 595.597
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr cx8 cmov mmx longrun
bogomips	: 1167.36

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
