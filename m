Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946034AbWBORNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946034AbWBORNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946038AbWBORNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:13:50 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:12704 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946034AbWBORNu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:13:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HP/dvvOCkvn8I+G5v8qrGtFutcVQD6gFmYofIgE12Oz/hEvYxJ/9OXsQwdB5u8QM/q2x6gObKH1Cky3uJ/9AzGsRdNi5agYRK+/RTYSOkGB+Lec0M9D2nBdV84R/A2oN8TlL9XP9YPTM1N7/nBlpkhu3gjSX4OXBoE0bNWoKqX0=
Message-ID: <728201270602150913j4e8292fdh8e53cfe988a27dd3@mail.gmail.com>
Date: Wed, 15 Feb 2006 11:13:48 -0600
From: Ram Gupta <ram.gupta5@gmail.com>
To: Michael Gilroy <mgilroy@a2etech.com>
Subject: Re: Kernel bug mm/page_alloc.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <002a01c63228$abda02f0$0a00a8c0@emachine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <002a01c63228$abda02f0$0a00a8c0@emachine>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/06, Michael Gilroy <mgilroy@a2etech.com> wrote:
> Hi,
>        I get a repeatable error due to failures in mm/page_alloc.c, errors
> occur during heavy utilisation of the file-system with bonnie++. I'm using
> an experimental driver for the RAID 6 operations however as the error

This problem seems related to intel F00F BUG. Is CONFIG_X86_F00F_BUG
enabled in your current kernel. If so then can you try with this
option disabled?

Regards
Ram Gupta
