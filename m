Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317640AbSG2THn>; Mon, 29 Jul 2002 15:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317779AbSG2THn>; Mon, 29 Jul 2002 15:07:43 -0400
Received: from 154-84-51-66.reonbroadband.com ([66.51.84.154]:33408 "EHLO
	tibook.netx4.com") by vger.kernel.org with ESMTP id <S317640AbSG2THm>;
	Mon, 29 Jul 2002 15:07:42 -0400
Message-ID: <3D4592D3.50505@embeddededge.com>
Date: Mon, 29 Jul 2002 15:09:07 -0400
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Tom Rini <trini@kernel.crashing.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 3 Serial issues up for discussion (was: Re: Serial core problems
 on embedded PPC)
References: <20020729174341.GA12964@opus.bloom.county> <20020729181352.27999@192.168.4.1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> Especially, please, let's avoid once for all statically defined table,
> on PPC (specifically on pmac) the table is really dynamic,

Since all of the discussion here has been around "standard" UARTs.....

I know Russell mentioned this, and it has been discussed in the past,
but I'm most interested in being able to include non-165xx style UARTs
in the /dev/tty<something>.  Systems may be exclusively non-165xx UARTs,
or a mix of both.  The problems to solve are drivers fighting over minor
device numbers and assumptions about the system console.

Thanks.


	-- Dan

