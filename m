Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135930AbRARWtm>; Thu, 18 Jan 2001 17:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136137AbRARWtc>; Thu, 18 Jan 2001 17:49:32 -0500
Received: from palrel1.hp.com ([156.153.255.242]:46609 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S135930AbRARWtP>;
	Thu, 18 Jan 2001 17:49:15 -0500
Message-ID: <3A6772E1.56263536@cup.hp.com>
Date: Thu, 18 Jan 2001 14:49:05 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <200101182030.XAA08626@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > So if I understand  all this correctly...
> >
> > The difference in ACK generation
> 
> CORK does not affect receive direction and, hence, ACK geneartion.

I was asking how the semantics of cork interacted with piggybacking
ACK's on data flowing the other way. Was I wrong in assuming that the
Linux TCP piggybacks ACKs?

rick
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
