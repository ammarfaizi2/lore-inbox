Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265113AbRFZVmk>; Tue, 26 Jun 2001 17:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265115AbRFZVm3>; Tue, 26 Jun 2001 17:42:29 -0400
Received: from zero.tech9.net ([209.61.188.187]:38916 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S265113AbRFZVm1>;
	Tue, 26 Jun 2001 17:42:27 -0400
Subject: Re: failed kernel 2.4.2 build after applying the patch ac28
From: Robert Love <rml@tech9.net>
To: "MEHTA,HIREN " "(A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880ACA@xsj02.sjs.agilent.com>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880ACA@xsj02.sjs.agilent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 26 Jun 2001 17:42:55 -0400
Message-Id: <993591787.579.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jun 2001 15:35:09 -0600, MEHTA,HIREN (A-SanJose,ex1) wrote:
> I tried to build the 2.4.2 kernel after applying patch ac28
> (patch-2.4.2-ac28) and it failed :-((
> 
> When it failed it gave the following message :
> 
> *** Install db development libraries
> 
> I thought kernel build should be independent of any userland libraries.


i think this is because aicasm (the assembler for the aha7xxx scsi
firmware) uses db1 to build itself.  are you compiling aha7xxx support
into the kernel?

upgrade to the newest kernel (2.4.5-ac18) and rebuilding the firmware is
optional, so you won't need the berekely db libraries.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

