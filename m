Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbUK0AiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUK0AiZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbUK0Ae7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 19:34:59 -0500
Received: from hermes.domdv.de ([193.102.202.1]:37892 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S263081AbUK0Aag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 19:30:36 -0500
Message-ID: <41A7CA94.60309@domdv.de>
Date: Sat, 27 Nov 2004 01:30:12 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Matthew Wilcox <matthew@wil.cx>, Alexandre Oliva <aoliva@redhat.com>,
       dhowells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>	 <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>	 <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>	 <1101422103.19141.0.camel@localhost.localdomain>	 <41A7C68D.3060302@domdv.de> <1101515200.21273.4320.camel@baythorne.infradead.org>
In-Reply-To: <1101515200.21273.4320.camel@baythorne.infradead.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Sat, 2004-11-27 at 01:13 +0100, Andreas Steinmetz wrote:
> 
>>And how do you want to deal with the fact that up to now all the 
>>netfilter headers required for userspace programming live in the kernel 
>>include tree? Now this has been like this for quite some years. Shall 
>>one no longer use netfilter?
> 
> 
> Don't get me started on fucking netfilter. Have you tried running 32-bit
> userspace on a 64-bit kernel recently? Throw away the fucking netfilter
> shite and burn it.
> 

I know very well about this problem. Still, you can easily use 64-bit 
applications with regards to netfilter. If you are so annoyed about this 
problem I would suggest you contact the netfilter developers to find a 
solution :-)

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
