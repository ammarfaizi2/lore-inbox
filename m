Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLANbo>; Fri, 1 Dec 2000 08:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQLANbe>; Fri, 1 Dec 2000 08:31:34 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:6669 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129231AbQLANbX>;
	Fri, 1 Dec 2000 08:31:23 -0500
Date: Fri, 1 Dec 2000 14:00:42 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>, Ivan Passos <lists@cyclades.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
Message-ID: <20001201140042.A8572@se1.cogenit.fr>
In-Reply-To: <20001201233227.A9457@metastasis.f00f.org> <200012011207.eB1C78523251@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <200012011207.eB1C78523251@flint.arm.linux.org.uk>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> écrit :
[...]
> We already have a standard interface for this, but many drivers do not
> support it.  Its called "ifconfig eth0 media xxx":
> 
> bash-2.04# ifconfig --help
> Usage:
>   ifconfig [-a] [-i] [-v] [-s] <interface> [[<AF>] <address>]
> ...
>   [mem_start <NN>]  [io_addr <NN>]  [irq <NN>]  [media <type>]

Ok. Hmmm... If I want to do something like 
'ifconfig scc0 media some_frequency up' as I hope to set scc0 as a DCE (or 
ifconfig scc0 media auto up' for a DTE), I must teach ifconfig.c to 
distinguish Ethernet and synchrone interface based on interface.type, right ? 

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
