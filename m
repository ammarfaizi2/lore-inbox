Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVLAMXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVLAMXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVLAMXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:23:40 -0500
Received: from [82.94.235.172] ([82.94.235.172]:30134 "EHLO
	mail.hipersonik.com") by vger.kernel.org with ESMTP id S932185AbVLAMXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:23:39 -0500
From: Norbert van Nobelen <norbert-kernel@hipersonik.com>
To: "Miro Dietiker, MD Systems" <info@md-systems.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: Networking delay & timeout
Date: Thu, 1 Dec 2005 13:26:24 +0100
User-Agent: KMail/1.8.2
References: <000001c5f66a$28b76100$4001a8c0@MDSYSPORT>
In-Reply-To: <000001c5f66a$28b76100$4001a8c0@MDSYSPORT>
Organization: Hipersonik.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512011326.24712.norbert-kernel@hipersonik.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few questions:
- Did you do any relevant upgrades at all at any of the involved machines?
- Did you do a ping from a second machine from the same location, or better 
another machine from another location
- traceroute for problems in between?



On Thursday 01 December 2005 12:27, you wrote:
> Hi!
>
> I'm having some trouble with "general networking", using simple Ethernet
> Gigabit interfaces on a routing computer (routing in between eth0,
> eth1).
>
> My network has 10 Servers and a public internet gateway. Router does arp
> proxying.
> If I "ping" from a Internet-computer (unrecently used before to connect
> to that server), my firewall produces Initial delays around 1000ms!
>
> C:\>ping abcde
> Ping frankonia [X.X.X.X] mit 32 Bytes Daten:
> Antwort von X.X.X.X: Bytes=32 Zeit=441ms TTL=53
> Antwort von X.X.X.X: Bytes=32 Zeit=33ms TTL=53
> Antwort von X.X.X.X: Bytes=32 Zeit=32ms TTL=53
> Antwort von X.X.X.X: Bytes=32 Zeit=32ms TTL=53
>
> If i ping later on, delay remains that low.
>
> In some certain cases, the target even is temporarily unreachable...
>
> Is there anyone who can tell me how to debug the source of this delay?
> Is it possible to reduce it?
> The initial delay seems to be sourced by the linux router, while the
> temporary unavailability seems to be sourced by the target server,
> temporarily not answering to packets!
>
> Do you have any suggestion for analternative list to post this question?
>
> +-------------------------------+  +-------------------------------+
>
> | Miro Dietiker                 |  | MD Systems Miro Dietiker      |
>
> +-------------------------------+  +-------------------------------+
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
________
www.hipersonik.com : Open source experts
