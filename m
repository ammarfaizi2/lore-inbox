Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRDAQiw>; Sun, 1 Apr 2001 12:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRDAQim>; Sun, 1 Apr 2001 12:38:42 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:28684 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S129164AbRDAQi0>;
	Sun, 1 Apr 2001 12:38:26 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <Pine.LNX.3.96.1010329234142.14911E-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 01 Apr 2001 00:41:59 +0200
In-Reply-To: Jeff Garzik's message of "Thu, 29 Mar 2001 23:43:31 -0600 (CST)"
Message-ID: <m3y9tl4l3c.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> I'm not suggesting you modify ethtool for your needs :)   But ethtool
> perfectly illustrates the technique of using a single socket ioctl
> (SIOCETHTOOL) to extend a set of standard, domain-specific ioctls
> (ETHTOOL_xxx) to Linux networking drivers.

I know. The problem is I don't see here any advantages over many SIOCxxx
command codes, while there are disadvantages.
Simple things are IMHO better, and ioctl was designed to handle many
simple commands (instead of one complex).

Am I missing something?
-- 
Krzysztof Halasa
Network Administrator
