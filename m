Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269354AbTGOSKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269412AbTGOSKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:10:31 -0400
Received: from mail3.iserv.net ([204.177.184.153]:48054 "EHLO mail3.iserv.net")
	by vger.kernel.org with ESMTP id S269354AbTGOSK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:10:26 -0400
Message-ID: <3F1446E9.8040409@didntduck.org>
Date: Tue, 15 Jul 2003 14:24:41 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
References: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com> <3F14348B.4050606@didntduck.org> <20030715175909.GA17226@lsd.di.uminho.pt>
In-Reply-To: <20030715175909.GA17226@lsd.di.uminho.pt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luciano Miguel Ferreira Rocha wrote:
> On Tue, Jul 15, 2003 at 01:06:19PM -0400, Brian Gerst wrote:
> 
>>Use HZ/2 instead.  GCC doesn't optimize floating point constants to the 
>>same degree it does integers, because it doesn't know what mode 
>>(rounding, precision) the FPU is in.
> 
> 
> Isn't (HZ >> 1) better?

Same thing.  GCC knows that division by a power of 2 is just a shift.

--
				Brian Gerst

