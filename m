Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLAMqQ>; Fri, 1 Dec 2000 07:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLAMqH>; Fri, 1 Dec 2000 07:46:07 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:2058 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129183AbQLAMps>;
	Fri, 1 Dec 2000 07:45:48 -0500
Date: Fri, 1 Dec 2000 13:15:01 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Chris Wedgwood <cw@f00f.org>
Cc: Ivan Passos <lists@cyclades.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
Message-ID: <20001201131501.A8145@se1.cogenit.fr>
Reply-To: romieu@ensta.fr
In-Reply-To: <Pine.LNX.4.10.10011301103320.4692-100000@main.cyclades.com> <20001201100124.A4986@se1.cogenit.fr> <20001201233227.A9457@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001201233227.A9457@metastasis.f00f.org>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> écrit :
[...]
> o across different networks cards -- I've been thinking about it of
> late as I had to battle with this earlier this week; depending on
> what network card you use, you need different magic incarnations to
> do the above.
> 
> A standard interface is really needed; unless anyone objects I may
> look at drafting something up -- but it will require some input if it
> is not to look completely Ethernet centric.

Regarding the clocking issue, synchronous interfaces need to know wether
the signal is externally provided or internally generated. The latter
implies to set the frequency too.

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
