Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSLPTsP>; Mon, 16 Dec 2002 14:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbSLPTsP>; Mon, 16 Dec 2002 14:48:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40710 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261310AbSLPTsO>; Mon, 16 Dec 2002 14:48:14 -0500
Message-ID: <3DFE2FBE.7080306@zytor.com>
Date: Mon, 16 Dec 2002 11:55:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org,
       terje.eggestad@scali.com
Subject: Re: Intel P6 vs P7 system call performance
References: <20021215220132.GB6347@elf.ucw.cz> <200212160733.gBG7XhD67922@saturn.cs.uml.edu> <20021216111759.GA24196@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20021216111759.GA24196@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
>>The vsyscall stuff costs you on every syscall. It's nice for
> 
> 
> Well, the cost is basically one call. That's not *that* big cost.
> 

You absolutely, positively *need* the call anyway.  SYSENTER trashes EIP.

	-hpa


