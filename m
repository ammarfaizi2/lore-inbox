Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWJECF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWJECF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 22:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWJECF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 22:05:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:30697 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751330AbWJECFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 22:05:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LLJfz0UgDflWQIJvXl/gGQWSljmsrcFuHJBxGdo3VFbwQdSXvQoYg1wqN8S/COAvOZ+stto3BXTJ3QS1dMG4cgwStdyveuSnaeW6wNPa7qpADC2ikvztlrfd3oQKwWhLuUkFKkH+rvbHIAno34E2EzfRgWhTGGe9N/fVt9XdD3s=
Message-ID: <a762e240610041905w6722b4c1i786a99df3af0a16d@mail.gmail.com>
Date: Wed, 4 Oct 2006 19:05:52 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Martin Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Cc: "Andi Kleen" <ak@suse.de>, vgoyal@in.ibm.com,
       "Andrew Morton" <akpm@osdl.org>, "Steve Fox" <drfickle@us.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       kmannth@us.ibm.com, "Andy Whitcroft" <apw@shadowen.org>
In-Reply-To: <45245B03.2070803@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20061004170659.f3b089a8.akpm@osdl.org>
	 <20061005005124.GA23408@in.ibm.com> <200610050257.53971.ak@suse.de>
	 <45245B03.2070803@mbligh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/06, Martin Bligh <mbligh@mbligh.org> wrote:
> Andi Kleen wrote:
> >>I think most likely it would crash on 2.6.18. Keith mannthey had reported
> >>a different crash on 2.6.18-rc4-mm2 when this patch was introduced first
> >>time. Following is the link to the thread.
> >
> >
> > Then maybe trying 2.6.17 + the patch and then bisect between that and -rc4?
>
> I think it's fixed already in -git22, or at least it is for the IBM box
> reporting to test.kernel.org. You might want to try that one ...

Fixed or hidden... hard to say at this point.   I think it could be a
werid interaction between patches and or config options.  I will see
tommorrow if I can recreate again.

Thanks,
  Keith
