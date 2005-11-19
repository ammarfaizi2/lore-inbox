Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVKSVMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVKSVMe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVKSVMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:12:33 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:5234 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750829AbVKSVMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:12:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=PBjqWjQd96xWZV89ZtOd7IiqK2vIXWbi2/3UOb5OUP+J+cCXdgq2B2mYrrZzBNSn635MuwJHVcB61w461xauSfUDjSCigD0JKjpl8ZloNDTzpYluDE8s03eTEjxnQm9pVZ0dalKIgUu88XxIf2Al5E86umiqpZ7ympr9R0J7wEU=
Subject: Re: AMD 64 system clock speed
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: jstipins@umich.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051118200132.jiwizt3ho0ook00w@web.mail.umich.edu>
References: <20051118200132.jiwizt3ho0ook00w@web.mail.umich.edu>
Content-Type: text/plain
Date: Sat, 19 Nov 2005 13:12:26 -0800
Message-Id: <1132434746.18950.9.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 20:01 -0500, jstipins@umich.edu wrote:
> Hi there,
> 
> My earlier question regarding the glibc "make check" nptl/tst-clock2.c
> failure turns out to be due to my system clock running 3x normal speed.
> 
> Evidently, this is a known issue with 2.6.x kernels running on AMD 64
> processors.  The "noapic" boot option fixes the clock problem, but disrupts
> other things... ethernet does work, etc.  The solution seems to be using
> "apci=noirq noapic" as boot options.
> 
> I am using the 2.6.14.2 kernel, and still need to use those boot parameters.
> What is the current state of this bug?

Interestingly, I found out last night that the 2.4.26 kernel can
recognize both processors in my X2. Unfortunately, it had the same time
synchronization issues as the newer 2.6.12+ kernels that I have been
running. It isn't solely related to the new kernel series.

--
Chris Largret <http://daga.dyndns.org>

