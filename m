Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVJNHH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVJNHH4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 03:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVJNHH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 03:07:56 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:28935 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S932213AbVJNHHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 03:07:55 -0400
Message-ID: <434F5940.9010500@tuxrocks.com>
Date: Fri, 14 Oct 2005 01:07:44 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Kconfig Dependencies for CONFIG_NET_CLS_RSVP6
References: <434F5247.2040007@tuxrocks.com> <20051013.235907.66789139.davem@davemloft.net>
In-Reply-To: <20051013.235907.66789139.davem@davemloft.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David S. Miller wrote:
> From: Frank Sorenson <frank@tuxrocks.com>
> Date: Fri, 14 Oct 2005 00:37:59 -0600
> 
> 
>>I noticed that I can still select "Special RSVP classifier for IPv6"
>>even if "The IPv6 protocol" isn't selected.  Should CONFIG_NET_CLS_RSVP6
>>depend on or select IPV6?
>>
>>Currently:
>>Depends on: NET && NET_CLS && NET_QOS
> 
> 
> It doesn't need the ipv6 stack at all, it's just a classifier
> that looks at packet headers and makes decisions.

Okay, I suppose that makes more sense now.  I just wanted to check it
through, since I figured I'd turned off everything related to IPv6 :)

Thanks for explaining,

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDT1lAaI0dwg4A47wRAuXVAKCWBcZj3OTK8wLZInGE7eIegtrBeACg7GOt
gM0finkJL0tRmXm9685vS10=
=8M+k
-----END PGP SIGNATURE-----
