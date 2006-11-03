Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753395AbWKCRJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbWKCRJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbWKCRJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:09:41 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:26501 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1753397AbWKCRJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:09:40 -0500
Date: Fri, 3 Nov 2006 18:09:39 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: Andrew Morton <akpm@osdl.org>, Gabriel C <nix.or.die@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: New filesystem for Linux
In-Reply-To: <20061103171443.GA16912@flower.upol.cz>
Message-ID: <Pine.LNX.4.64.0611031808280.15472@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
 <20061102174149.3578062d.akpm@osdl.org> <20061103171443.GA16912@flower.upol.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In gmane.linux.kernel, you wrote:
> []
>> From: Andrew Morton <akpm@osdl.org>
>>
>> As Mikulas points out, (1 << anything) won't be evaluating to zero.
>
> How about integer overflow ?

C standard defines that shifts by more bits than size of a type are 
undefined (in fact 1<<32 produces 1 on i386, because processor uses only 5 
bits of a count).

Mikulas
