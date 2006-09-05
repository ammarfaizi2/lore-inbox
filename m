Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWIES51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWIES51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWIES51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:57:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:40098 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030220AbWIES5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:57:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oAxpnOkMGyGmnTMTWnBYTSuCXY5jXUv7WjRV+El7PMyT4XEiXWrzPdIRuYsNE+EgqG3bm86w2yUVgcWjZxltQP9X/BbKgPYrkUkCx9LY1Elcvr6XOVXfjTBBjTuUFrnUhpS4plkGNmOtiqWpiuaswvag+qOAbBStSpsXhdUMmdA=
Message-ID: <a762e240609051157p47084522o7df1730cf6f6fd29@mail.gmail.com>
Date: Tue, 5 Sep 2006 11:57:23 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Om Narasimhan" <om.turyx@gmail.com>
Subject: Re: howto map HDT dumped addresses to AMD64 kernel virtual addresses.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6b4e42d10609051048o23b8c5edj2ab110bd87acd57f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609051048o23b8c5edj2ab110bd87acd57f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/06, Om Narasimhan <om.turyx@gmail.com> wrote:
> Hi,
> I am running a kernel (Suse Enterprise 9 with SP3) and it is hanging
> somewhere in the kernel. By hooking up HDT from AMD, I got a the
> assembly dump of the routine which causes the infinite loop. How
> should I map the addresses dumped by HDT in the format SEG:Offset
> (e.g,
> 0033:00000000_00400C18   mov   esi,[loc_0000000000501a64h]
> 0033:00000000_00400C1E   test   esi,esi
> 0033:00000000_00400C20   jz   loc_0000000000400c30h
> ...etc)
> to kernel virtual address space?

I don't know about your HDT (never used one) but have you already
tried the regular debug paths (nmi watchdog/sysrq/crashdump/kdb) that
SLES9 has?

Thanks,
  Keith
