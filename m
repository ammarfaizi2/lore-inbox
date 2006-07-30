Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWG3PIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWG3PIe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 11:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWG3PIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 11:08:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:49671 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932325AbWG3PId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 11:08:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=L+A8h10ORUgE92oTum0msJd7y3mTRmmV1yEvUqHScY9L4Il2LWCnlVnpcC0kPDWZwpEO3M56EcSgsOY8EIg2mzKnnYwTyl6/3R9FDGrzqB0SEpA6DLGAgg4pF7pjCH4wj6gzQ45PyPi+htJ4QUf2imE0q/rL2IyYal+2wYCb7Ts=
Message-ID: <44CCCB74.9010605@gmail.com>
Date: Sun, 30 Jul 2006 17:08:13 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Avi Kivity <avi@argo.co.il>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <44CC97A4.8050207@gmail.com>  <44CCC4CA.6000208@argo.co.il> <1154271283.2941.27.camel@laptopd505.fenrus.org>
In-Reply-To: <1154271283.2941.27.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>> So 2 questions are:
>>> 1) howto FP in kernel
>>>
>> kernel_fpu_begin();
>> c = d * 3.14;
>> kernel_fpu_end();

Yup, I know about this possibility, but this is only x86 specific?!

> unfortunately this only works for MMX not for real fpu (due to exception
> handling uglies)

concludes it's not multiplatform at all... For that reasen I (maybe) want some 
"protocol" for communication with US, where I can easily compute it.

Another way could be rtai (there is FP implemented IIRC), but it means having 
out-of-kernel driver.

thanks,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
