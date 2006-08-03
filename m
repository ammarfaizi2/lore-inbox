Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWHCBUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWHCBUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 21:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWHCBUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 21:20:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:53175 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932113AbWHCBUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 21:20:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dpC32c8OUGTdFbWOESBDWSf/a9BNF8b14YdiDk7uutf7OsrzPXZuYCBe8KUP9kN08o21eiFBsUVnSDCFlmKgmu18vyhl6nhPm6ovnMCVpoiA8jX9VCEsLIHtxPtoB26b4VP0yuBWtz5bleqtRwazPm+y77EhJwk1Ij7ukNRb3ug=
Message-ID: <5bdc1c8b0608021820u5235c491tdf9b25f5906fe3f8@mail.gmail.com>
Date: Wed, 2 Aug 2006 18:20:50 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: 2.6.17-rt8 crash amd64
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060802011809.GA26313@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060802011809.GA26313@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
>
> Hello folks,
>
> I'm getting this:
>
> [   41.989355] BUG: scheduling while atomic: udevd/0x00000001/1101
<SNIP>
> [   42.198871]        <ffffffff8025ce3d>{error_exit+0}
> [   42.204040]        <ffffffff8025bf22>{system_call+126}
> [   42.209715] ---------------------------
> [   42.213716] | preempt count: 00000001 ]
> [   42.217715] | 1-level deep critical section nesting:
> [   42.222879] ----------------------------------------
> [   42.228043] .. [<ffffffff8025ef7d>] .... __schedule+0xb3/0xb2a
> [   42.234150] .....[<ffffffff8025fd89>] ..   ( <= schedule+0xec/0x11e)
> [   42.240796]
> [   53.347726] NET: Registered protocol family 10
> [   53.353240] IPv6 over IPv4 tunneling driver
>
>

Hi,
   Similar problems here also but in my case it said '2-level deep'
and I had different stuff after that message. AMD64/ NVidia MB. I
don't have a second Linux machine handle to do the remote boot console
thing. If it's important that I send in more info I'll get a camera or
something like that. Let me know if it's required.

   Anyway, not a one machine problem at all.

Cheers,
Mark
