Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVDWGQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVDWGQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 02:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVDWGQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 02:16:58 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:30554 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261156AbVDWGQz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 02:16:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fMGuRSBkD+N7I8WVyrw+shCqwZ86S3mET9wIJV0GhpEyxhLr5gkSvxUesQcto6l4XiUDyxeRPrKYWSWFO1ICmVWV0ZC4oih2lNFuwg48oC8B1CFJ1pgRD85BFLFiP9wzPmqyz6i4SQLobDbnRYmW0l4j5nGgH94b1y4dORhKxsI=
Message-ID: <2a4f155d05042223167d0db353@mail.gmail.com>
Date: Sat, 23 Apr 2005 09:16:52 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: James Purser <purserj@ksit.dynalias.com>
Subject: Re: Compile error on microtek.c in drivers/usb/image/
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1114234140.3074.6.camel@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1114234140.3074.6.camel@kryten>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like its fixed already.See http://lkml.org/lkml/2005/4/21/247

ismail



On 4/23/05, James Purser <purserj@ksit.dynalias.com> wrote:
> When compiling from the git archive ran across this error, I changed the
> offending FAILUR to FAILED and it compiled fine, however not knowing the
> ins and outs, Im not sure if this is going to fix the problem.
> 
> System: Fedora Core 2
> Compiler: gcc-3.3.3 (Redhat Version)
> 
> drivers/usb/image/microtek.c: In function `mts_scsi_abort':
> drivers/usb/image/microtek.c:338: error: `FAILURE' undeclared (first use
> in this function)
> drivers/usb/image/microtek.c:338: error: (Each undeclared identifier is
> reported only once
> drivers/usb/image/microtek.c:338: error: for each function it appears
> in.)
> make[3]: *** [drivers/usb/image/microtek.o] Error 1
> make[2]: *** [drivers/usb/image] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
> 
> 
> -- 
> James Purser
> http://ksit.dynalias.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Time is what you make of it
