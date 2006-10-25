Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422923AbWJYEAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422923AbWJYEAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 00:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161339AbWJYEAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 00:00:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:31167 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161338AbWJYEAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 00:00:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ViqfzduZOsb07JnxLPxtbtIPgd5rCxrWAD+ilUNTtGiKOjFyLffCWJcDBCnv+wNt8fFcXJHdRfcx6tz2RsldPRsUlvM2P5G+QUZV9gt2QJm29AotrVuC6+GQuWsLw9S1BBXxriF/5KQLEAtOTR3Nwt60yKrmvL26l5SAGNY2xVk=
Message-ID: <86802c440610242100gb1e3199lda1a2e1a7900ceb6@mail.gmail.com>
Date: Tue, 24 Oct 2006 21:00:29 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>
Subject: Re: [PATCH] x86_64 irq: reuse vector for __assign_irq_vector
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA412D75A@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA412D75A@ssvlexmb2.amd.com>
X-Google-Sender-Auth: d6317eef19e8c76c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

I think this patch could be in your tree after Eric's tree is getting
into mainstream.

YH

On 10/24/06, Lu, Yinghai <yinghai.lu@amd.com> wrote:
> >From: Andi Kleen [mailto:ak@suse.de]
> >Is that still needed with Eric's latest patches? I suppose not?
>
> It needs Eric's
>
> x86_64-irq-simplify-the-vector-allocator.patch
> x86_64-irq-only-look-at-per_cpu-data-for-online-cpus.patch
>
> Those two are in -mm tree now.
>
> Otherwise it can not be applied without FAIL.
>
> YH
>
