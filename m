Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136829AbREJQIl>; Thu, 10 May 2001 12:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136831AbREJQIb>; Thu, 10 May 2001 12:08:31 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:61871 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136829AbREJQIP>;
	Thu, 10 May 2001 12:08:15 -0400
Message-ID: <3AFABCE8.8D0BF42A@mandrakesoft.com>
Date: Thu, 10 May 2001 12:08:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock/crash with Quad tulip card in 2.4
In-Reply-To: <989507596.18286.0.camel@olive>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yann Dupont wrote:
> Hello. I'm having problem with Quad eth100 tulip (digital 21140) cards.

Unfortuantely a recent merge of the latest Becker code fixed these chips
(and 2104[01]), and promptly broke support for other, more popular
chips.  :(

I'm working on fixing this right now; until then, the "de4x5" driver
should work for you.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
