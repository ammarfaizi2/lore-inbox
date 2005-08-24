Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbVHXTi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbVHXTi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVHXTi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:38:59 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:16292 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751488AbVHXTi6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:38:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rWizd6q/SfbPtCuLv6IpIZuN9t2lbDZ8wljp7x/aMycicKd/BhGrzROTByWiljRcgTnbM0bWxCnSY5ELv6pT3LdUvNtSNFrcuRBDvto48xufKyq5YjadvAoqhRncSz+qCZlyQCCtu8JmBSTx+3AhrqtozwjJ3PiETDnAt2zvtZA=
Message-ID: <69304d1105082412384bde82f7@mail.gmail.com>
Date: Wed, 24 Aug 2005 21:38:56 +0200
From: Antonio Vargas <windenntw@gmail.com>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 0/5] Virtualization patches, set 4
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>
In-Reply-To: <200508241839.j7OIdp5A001866@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508241839.j7OIdp5A001866@zach-dev.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/05, Zachary Amsden <zach@vmware.com> wrote:
> Transparent paravirtualization patches, set 4.  This batch includes
> mostly MMU hooks that can be used by the hypervisor for page allocation,
> and allows the kernel to be compiled to step out of the way of the
> hypervisor by making a hole in linear address space.
> 
> Patches are based off 2.6.13-rc6-mm2; I've tested i386 PAE and non-PAE
> as well as um-i386.  Although these are mostly i386 specific, some of
> the concepts are starting to apply to virtualization of other
> architectures as well.

Zach, have you had a look at the mac-on-linux virtualizer? It's coded
for arch-ppc but most probably some of these generic concepts could
get merged together...

-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
