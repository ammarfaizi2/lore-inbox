Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312353AbSCUO57>; Thu, 21 Mar 2002 09:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312354AbSCUO5u>; Thu, 21 Mar 2002 09:57:50 -0500
Received: from ns.ithnet.com ([217.64.64.10]:24074 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S312353AbSCUO5i>;
	Thu, 21 Mar 2002 09:57:38 -0500
Date: Thu, 21 Mar 2002 15:57:31 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: green@namesys.com, sneakums@zork.net, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020321155731.2490f859.skraw@ithnet.com>
In-Reply-To: <20020321154500.117e8acc.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002 15:45:00 +0100
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> Hello,
> 
> just in case there is still somebody interested:
> the problem stays the same with upgrading the server to 2.4.19-pre4

Hello Oleg,

detailed investigation showed the following interesting results:

1) the problem is not dependant on any nfs-flags, whatever I try it shows up
2) the problem _is_ dependant on the fs mounted in the following form:
mounting two fs that are located on the _same_ reiserfs _works_.
mounting two fs that are located on _different_ reiserfs _does not work_.

How about that?

Regards,
Stephan

