Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754255AbWKRIQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255AbWKRIQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 03:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbWKRIQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 03:16:26 -0500
Received: from terminus.zytor.com ([192.83.249.54]:7379 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1754254AbWKRIQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 03:16:26 -0500
Message-ID: <455EC143.7040708@zytor.com>
Date: Sat, 18 Nov 2006 00:16:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Oleg Verych <olecom@flower.upol.cz>, LKML <linux-kernel@vger.kernel.org>,
       vgoyal@in.ibm.com, akpm@osdl.org, rjw@sisk.pl, ebiederm@xmission.com,
       Reloc Kernel List <fastboot@lists.osdl.org>, pavel@suse.cz,
       magnus.damm@gmail.com
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
References: <20061117223432.GA15449@in.ibm.com> <20061118070101.GA14673@flower.upol.cz> <455EAF54.5090500@zytor.com> <200611180906.21340.ak@suse.de>
In-Reply-To: <200611180906.21340.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Finding panic=.. would require writing a command line parser in 16bit assembly.
> I have my doubts that's a good use of anyone's time.
> 

There already is one, in the EDD code.

	-hpa
