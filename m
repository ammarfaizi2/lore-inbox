Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135882AbRDTMHn>; Fri, 20 Apr 2001 08:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135880AbRDTMHd>; Fri, 20 Apr 2001 08:07:33 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:25606 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S135882AbRDTMHW> convert rfc822-to-8bit; Fri, 20 Apr 2001 08:07:22 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: epic100 error
Date: Fri, 20 Apr 2001 14:07:11 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, epic@skyld.com
In-Reply-To: <20010417184552.A6727@core.devicen.de> <01042013091501.07156@antares> <3AE01E97.E41399F7@mandrakesoft.com>
In-Reply-To: <3AE01E97.E41399F7@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <01042014071100.01203@antares>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 April 2001 13:33, Jeff Garzik wrote:
> Here's a suggestion to try: go through epic100.c and write 0x12
> unconditionally to MIICfg register.  Right now it is conditional:  if
> (dev->if_port...) out(0x12,ioaddr+MIICfg);

I changed all three such lines. Same behavior as before.

<offtopic>
You also cc-d this to epic@skyld.com. My message to this address 
bounced. Is this a problem with my provider only?

'A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:
  epic@skyld.com:
    unrouteable mail domain "skyld.com"'
</offtopic>

-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
