Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWGUFeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWGUFeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 01:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWGUFeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 01:34:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23402 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1160999AbWGUFeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 01:34:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DqIGPuUMtBwHB173aUMbssWaLkRBNmIftEl25rK2PB2bw72Od5xDuRG7pwhtYiBM4+2wC0i4DDYDOQKIrJo9ItGW3d0LADF3q+uMvRrcWPJ0RhsKVCX2r3b6CWo422AhroB8SEfDxlVgo90VsOxLhiO3gm0RGB0p5ra7jKBe++g=
Message-ID: <bda6d13a0607202234xc7d58a1t2a440c8458596582@mail.gmail.com>
Date: Thu, 20 Jul 2006 22:34:08 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Irfan Habib" <irfan.habib@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: why is intercepting system calls considerred bad?
In-Reply-To: <3420082f0607202206j78569b3fm56d61138c65426bf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3420082f0607202206j78569b3fm56d61138c65426bf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/06, Irfan Habib <irfan.habib@gmail.com> wrote:
> HI,
>
> I recently met a kernel janitor, who told me that intercepting system
> calls is undesirable, why?

I'll bite.

You intercept. Somebody else intercepts. You want to stop intercepting.

For this reason, anybody who intercepts a system call must be compiled
in, and if two intercept the same system call, than the link order
dictates behavior.

Obviously not desirable.
