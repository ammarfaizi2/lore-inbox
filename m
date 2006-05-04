Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWEDWgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWEDWgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWEDWgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:36:43 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:49113 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750996AbWEDWgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:36:43 -0400
In-Reply-To: <55C365AA-2BA4-406C-8518-616F8182FAE5@kernel.crashing.org>
References: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org> <6B4D81B3-ECB5-4492-B3EE-16EAAEBF1405@kernel.crashing.org> <55C365AA-2BA4-406C-8518-616F8182FAE5@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2C632FEE-A487-44AB-ACEE-97C3000C14C4@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Fri, 5 May 2006 00:36:18 +0200
To: Kumar Gala <galak@kernel.crashing.org>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>  void __init setup_arch(char **cmdline_p)
>>>  {
>>>  	extern void do_init_bootmem(void);
>>> +	extern void setup_panic(void);
>>
>> Can those two go into a header file please?
>
> any suggestions on which header?

The new one should just go into arch/powerpc/kernel/setup.h;
the bootmem thing could go there as well perhaps.


Segher

