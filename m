Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752006AbWCJXCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWCJXCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 18:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWCJXCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 18:02:36 -0500
Received: from smtp-out.google.com ([216.239.45.12]:12491 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752006AbWCJXCf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 18:02:35 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=lbtzZYBT4Ub1EGaHBMTMyBjEiOQH0Wnw1Gywp3xKe/0uY3ho77qtL8L+vwAnamarC
	TvrjcFH4rM77ekbEsgHpg==
Message-ID: <545d88bc0603101502sea49c15g9807031bdab759ab@mail.google.com>
Date: Fri, 10 Mar 2006 15:02:21 -0800
From: dkegel <dkegel@google.com>
To: "Markus Gutschke" <markus@google.com>
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode on i386 (updated patch)
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <441200C4.8040502@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4410BB32.1020905@google.com>
	 <20060309184759.591e3551.akpm@osdl.org> <4410EC8A.4020808@google.com>
	 <20060309192232.2fd4767c.akpm@osdl.org> <441200C4.8040502@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/06, Markus Gutschke <markus@google.com> wrote:
> Once this change has made it into the kernel, I will try to get it
> propagated into libc.

Cool...

I could be wrong, but I think "propagating into libc" here means
"propagating into
the sanitized kernel headers, e.g. the set at
http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
