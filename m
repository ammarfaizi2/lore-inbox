Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312322AbSC3ATx>; Fri, 29 Mar 2002 19:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312323AbSC3ATn>; Fri, 29 Mar 2002 19:19:43 -0500
Received: from holomorphy.com ([66.224.33.161]:26027 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S312322AbSC3AT1>;
	Fri, 29 Mar 2002 19:19:27 -0500
Date: Fri, 29 Mar 2002 16:18:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 build breakage around blkpg.c
Message-ID: <20020330001859.GA21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20020328035926.GA10467@holomorphy.com> <20020329223501.GC9974@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> What hit me?

On Fri, Mar 29, 2002 at 11:35:02PM +0100, Pavel Machek wrote:
> gcc bug hit you. Workaround by adding volatile's to all local
> variables in affected function.

>From some other responses I got it was made clear to me that this
seems to do with generating an illegal instruction in response to
high register pressure around inline assembly.


Cheers,
Bill
