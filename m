Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbTEaSoB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 14:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbTEaSoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 14:44:01 -0400
Received: from holomorphy.com ([66.224.33.161]:32662 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264729AbTEaSn6 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 31 May 2003 14:43:58 -0400
Date: Sat, 31 May 2003 11:57:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: Nikita Danilov <Nikita@Namesys.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: const from include/asm-i386/byteorder.h
Message-ID: <20030531185709.GK8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gianni Tedesco <gianni@scaramanga.co.uk>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <16088.47088.814881.791196@laputa.namesys.com> <1054406992.4837.0.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054406992.4837.0.camel@sherbert>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-31 at 15:10, Nikita Danilov wrote:
>> Hello, 
>> include/asm-i386/byteorder.h contains strange __const__'s in function
>> definitions that have no effect:
>> static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
>> static __inline__ __const__ __u16 ___arch__swab16(__u16 x)

On Sat, May 31, 2003 at 07:49:53PM +0100, Gianni Tedesco wrote:
> shouldn't it be __attribute__((const)) to designate a pure function?

There is an __attribute__((pure)) IIRC.


-- wli
