Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288744AbSAIDAc>; Tue, 8 Jan 2002 22:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288745AbSAIDAX>; Tue, 8 Jan 2002 22:00:23 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:2168 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S288744AbSAIDAI> convert rfc822-to-8bit; Tue, 8 Jan 2002 22:00:08 -0500
Subject: Re: 2.2.20 vs 2.4.17 on 486 server
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Jacek =?iso-8859-13?Q?Pop=F9awski?= <jpopl@interia.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020108220229.A13462@localhost.localdomain>
In-Reply-To: <20020108220229.A13462@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-13
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 08 Jan 2002 21:59:58 -0500
Message-Id: <1010545201.1258.1.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that the ipchains compatibility in 2.4.17 is a hack.  You
really should use iptables and not use the ipchains in 2.4.x.  I do not
know if this will fix your problem.  However, I have very good luck with
iptables and 2.4.x vs. 2.2.x.

Trever Adams

On Tue, 2002-01-08 at 16:02, Jacek Popùawski wrote:
> I have simple 486 server with: 
> - 2 ISA ethernet cards (eepro.o)
> - ppp connection to Internet
> I installed 2.4.17 (then 2.4.18-pre2) there, and discovered, that two connected
> workstations has very bad Internet connection (for example it was impossible to
> watch huge www pages or download pictures, edonkey/kza transfers were small).
> So i tested:
> - WWW speed on server -> OK (every page opens without problems) 
> - scp transfer between server and workstations -> OK (more than 100KB/s)
> There is squid installed on my server. But even if I used it on workstation -
> WWW still works bad! Looks like something was really bad with MASQ. But
> everything was OK on much faster (k6-2 500) system.
> 
> So I installed 2.2.20 - and all problems disappeared!
> 
> I am almost sure I compiled similiar stuff to every kernel, there was exactly
> the same ipchains rules and route. How can I check what was bad with 2.4.x ? 


