Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWIMQwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWIMQwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWIMQwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:52:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:30836 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750717AbWIMQwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:52:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FOfeWdwLeDUYuitd3hOI8ACgmh+pDHPhH1bTLAqZ+u9jn3l5Q4/n785Mdeqpn35GemrHS9+I1O6nCFGs/4r7k3cf7i1Gyvl6gmLK24/MQUr/AiFHgZahLiwXKu2HWQw19KIFvdfIhZdKLxyEZ8kCU6mMO3PU2CgTxdGdrig6lH0=
Message-ID: <45083731.7040904@gmail.com>
Date: Wed, 13 Sep 2006 18:52:01 +0200
From: guest01 <guest01@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.5) Gecko/20060719 Thunderbird/1.5.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: calling kernel syscall manually
References: <4506A295.6010206@gmail.com>	 <1158068045.9189.93.camel@hades.cambridge.redhat.com>	 <450717A5.90509@cfl.rr.com> <1158101019.18619.113.camel@pmac.infradead.org>
In-Reply-To: <1158101019.18619.113.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> However, the _example_ that the OP gave of this 'third one' was in fact
> using the old _syscallX() macros which used to be found in the kernel's
> private header files. So I assumed that's what he meant, rather than
> open-coding his own inline assembly.
> 

Yes, indeed. I think we should use the _syscallX() macro, but
nevertheless I like the inline assembly example :-)

So these macros are no longer available in the latest kernel versions?
Ok, if that's true, I will use the example with the inline assembler
code and write a few lines, that these "macros" are no longer supported.

thxs


