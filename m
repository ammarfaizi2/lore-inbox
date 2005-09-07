Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVIGIwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVIGIwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 04:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVIGIwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 04:52:21 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:49888 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751123AbVIGIwU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 04:52:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UaMxSX5rd0wiJLyrynIM8X0++Zw5gc/ROd/K8UZqaB1dvTWLZCgGszjC2STY8r3q/mPbJwadSeSHV5KwUX0dxYhGhL/0mlVTRI/MhDIndP2feerFaZpUqF7U30nRRL9fHh8J8ErWIqf6dNQiFNj3N38Tprv8YwOj4JG1DsTEc9M=
Message-ID: <2cd57c900509070152518fac06@mail.gmail.com>
Date: Wed, 7 Sep 2005 16:52:17 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Prefetch kernel stacks to speed up context switch
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200509070829.j878TSg25898@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509070829.j878TSg25898@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/05, Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> Repost previously discussed patch (on Jul 27, 2005). Ingo did
> the same thing for all arch with 471 lines of patch.  I'm still
> advocating this little 30 lines patch, of 6 lines introduces
> prefetch_stack() generic interface.
> 
> Andrew, please consider -mm inclusion. Or advise me what I need
> to do to take this forward.  Thanks.
> 
> - Ken

Do you have any benchmarks?
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
