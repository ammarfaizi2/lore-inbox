Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267878AbTB1NYp>; Fri, 28 Feb 2003 08:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267871AbTB1NXy>; Fri, 28 Feb 2003 08:23:54 -0500
Received: from mx02.cyberus.ca ([216.191.240.26]:24836 "EHLO mx02.cyberus.ca")
	by vger.kernel.org with ESMTP id <S267782AbTB1NXu>;
	Fri, 28 Feb 2003 08:23:50 -0500
Date: Fri, 28 Feb 2003 08:33:48 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org, "" <netdev@oss.sgi.com>,
       "" <linux-net@vger.kernel.org>
Subject: Re: anyone ever done multicast AF_UNIX sockets?
In-Reply-To: <3E5E7081.6020704@nortelnetworks.com>
Message-ID: <20030228083009.Y53276@shell.cyberus.ca>
References: <3E5E7081.6020704@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Feb 2003, Chris Friesen wrote:

>
> It is fairly common to want to distribute information between a single
> sender and multiple receivers on a single box.
>
> Multicast IP sockets are one possibility, but then you have additional
> overhead in the IP stack.
>

I think this is a _very weak_  reason.
Without addressing any of your other arguements, can you describe what
such painful overhead you are talking about? Did you do any measurements
and under what circumstances are unix sockets vs say localhost bound
udp sockets are different? I am not looking for hand waving reason of
"but theres an IP stack".

cheers,
jamal



