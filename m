Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272770AbRIGQjf>; Fri, 7 Sep 2001 12:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272769AbRIGQjQ>; Fri, 7 Sep 2001 12:39:16 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:10905
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S272768AbRIGQjI>; Fri, 7 Sep 2001 12:39:08 -0400
Message-ID: <3B98F843.72120B25@nortelnetworks.com>
Date: Fri, 07 Sep 2001 12:39:31 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Julian Anastasov <ja@ssi.bg>, Wietse Venema <wietse@porcupine.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip 
         aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <20010907115416.A26786@castle.nmd.msu.ru> <Pine.LNX.4.33.0109071053390.1692-100000@u.domain.uli> <20010907124220.A27338@castle.nmd.msu.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:

> Using GETROUTE as Andi suggested is the other good alternative.
> But it won't work without NETLINK socket support compiled in.

If netlink isn't compiled in, "ip" won't work, true?

And if all they are using is "ifconfig", then SIOCGIFNETMASK should work,
because they will be forced to used the "ethx:y" alias syntax so the names will
be different.

Am I missing something?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
