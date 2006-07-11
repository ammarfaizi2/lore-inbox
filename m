Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWGKM4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWGKM4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWGKM4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:56:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:8491 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750732AbWGKM4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:56:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H/0LZLkiC5clB7rvhL3kHIcsAw7KQBHJgavl1gpUk9VNQrRmAS0rC5uzB6CMsYLFGXO0QKWDqZns9D90Qy16DZZ1qpstQ90I7mucwqfq+IgLVgIahA9ZraV8JGzIzs4ZwS8QFqaF8KU1YC7GPyb+qZujUJQuLdKEAMSZ6pXnfIc=
Message-ID: <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
Date: Tue, 11 Jul 2006 13:56:11 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Unfortunately, it doesn't compile for me.
>
> make O=/dir
> [..]
> CC      arch/i386/kernel/alternative.o
> {standard input}: Assembler messages:
> {standard input}:1954: Error: can't resolve `.data' {.data section} -
> `.Ltext0' {.text section}

I don't get any error (and kmemleak doesn't touch this file). Is this
with the 2.6.18-rc1 kernel?

-- 
Catalin
