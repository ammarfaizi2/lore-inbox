Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWJWPxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWJWPxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWJWPxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:53:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:48831 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751833AbWJWPxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:53:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ATsmRplm30cHasW15zFudfv6ej15LuBA0I51750V7gIGhXWyw+6CYfNCABxEzOw2oiyoY2hKukaE8b2dLT7C0czm1OeH2KXjE+CiXsJq6A9xVl/mEEw4TDCv9oa+2GyT/X5orZO+m/cif/eitz0L/PJ25QMDuDGbYpqPuqdcc5Y=
Message-ID: <86802c440610230853l31cd1e87ya7234f8bf44feffa@mail.gmail.com>
Date: Mon, 23 Oct 2006 08:53:06 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH] x86_64 irq: reuse vector for set_xxx_irq_affinity in phys flat mode
Cc: "Andi Kleen" <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>
In-Reply-To: <20061023081515.GQ4354@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <86802c440610230002x340e3f95pa8ee98caa02e7e@mail.gmail.com>
	 <20061023081515.GQ4354@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> Should I give this a spin? with or without Eric's two patches?
>
should be with Eric's patch with cpu_online... consistent.

It should be helpful to phys_flat. and that code should be reached by
flat (logical) mode.

YH
