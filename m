Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbVKIIDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbVKIIDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbVKIIDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:03:04 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:62658
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965276AbVKIIDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:03:03 -0500
Message-Id: <4371BB79.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 09:03:53 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] minor ELF addition
References: <4370AE20.76F0.0078.0@novell.com> <20051108145656.06e0d2b8.akpm@osdl.org>
In-Reply-To: <20051108145656.06e0d2b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andrew Morton <akpm@osdl.org> 08.11.05 23:56:56 >>>
>"Jan Beulich" <JBeulich@novell.com> wrote:
>>
>> A trivial addition to the ELF definitions.
>> 
>> ...
>>  #define STT_FILE    4
>> +#define STT_COMMON  5
>> +#define STT_TLS     6
>
>Is there any particular reason for adding these, or is it just a
>completeness thing?

NLKD needs STT_COMMON. STT_TLS is just for completeness (and probably
not of much use in the kernel, though Andi seemed to have at least
considered using TLS for x86-64's per-CPU data).


