Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275131AbRJAOzI>; Mon, 1 Oct 2001 10:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275129AbRJAOyu>; Mon, 1 Oct 2001 10:54:50 -0400
Received: from waste.org ([209.173.204.2]:31863 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S275117AbRJAOye>;
	Mon, 1 Oct 2001 10:54:34 -0400
Date: Mon, 1 Oct 2001 09:55:39 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Rik van Riel <riel@conectiva.com.br>, Kenneth Johansson <ken@canit.se>,
        "Randy.Dunlap" <rddunlap@osdlab.org>,
        Andreas Dilger <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.33.0110010924380.3436-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.30.0110010949130.23404-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001, Ingo Molnar wrote:

> > Face it, Ingo's use of "client" and "server" is contrary to accepted
> > usage. You can't finesse around it.
>
> 'server' is the box that serves content. 'client' is one that requests and
> accepts it. in the case of netconsole, it's the netconsole-module box that
> produces the messages, and the other one gets them.

Server is the side providing the service - direction of data is
irrelevant. If the service is logging, the side doing the logging is the
server. If the service is console message generation, then the machine
generating the messages is the server.  Client/server architecture
generally implies the possibility of multiple clients per server, and that
seems to make more sense with a 'logging server' than a 'console message
server'.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

