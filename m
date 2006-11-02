Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWKBOcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWKBOcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWKBOcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:32:15 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:63812 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1750838AbWKBOcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:32:14 -0500
Message-ID: <454A0165.7090009@qumranet.com>
Date: Thu, 02 Nov 2006 16:32:05 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "Hesse, Christian" <mail@earthworm.de>
CC: kvm-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [ANNOUNCE] kvm howto
References: <4549F1D5.8070509@qumranet.com> <200611021527.09664.mail@earthworm.de>
In-Reply-To: <200611021527.09664.mail@earthworm.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2006 14:32:10.0154 (UTC) FILETIME=[AE1AD0A0:01C6FE8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hesse, Christian wrote:
> On Thursday 02 November 2006 14:25, Avi Kivity wrote:
>   
>> I've just uploaded a HOWTO to http://kvm.sourceforge.net, including
>> (hopefuly) everything needed to get kvm running.  Please take a look and
>> comment.
>>     
>
>   CC [M]  /tmp/kvm-module/kvm_main.o
> {standard input}: Assembler messages:
> {standard input}:168: Error: no such instruction: `vmxon 16(%esp)'
> {standard input}:182: Error: no such instruction: `vmxoff'
> {standard input}:192: Error: no such instruction: `vmread %eax,%eax'
> {standard input}:415: Error: no such instruction: `vmwrite %ebx,%esi'
> {standard input}:1103: Error: no such instruction: `vmclear 16(%esp)'
> {standard input}:1676: Error: no such instruction: `vmptrld 16(%esp)'
> {standard input}:4107: Error: no such instruction: `vmwrite %esp,%eax'
> {standard input}:4119: Error: no such instruction: `vmlaunch '
> {standard input}:4121: Error: no such instruction: `vmresume '
>
> I get a number of errors compiling the module. No difference between the 
> downloaded tarball and my patched kernel tree. Any hints?
>   

You need a newer binutils.  I'm using binutils-2.16.91.0.6 (gotta love 
that version number), shipped with Fedora Core 5.

I'll update the howto to reflect this.

-- 
error compiling committee.c: too many arguments to function

