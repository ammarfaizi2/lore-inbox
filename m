Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267264AbTA0SUA>; Mon, 27 Jan 2003 13:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbTA0SUA>; Mon, 27 Jan 2003 13:20:00 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:23973 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S267264AbTA0SUA>;
	Mon, 27 Jan 2003 13:20:00 -0500
Date: Mon, 27 Jan 2003 19:28:56 +0100
To: "David S. Miller" <davem@redhat.com>
Cc: lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
       tobi@tobi.nu
Subject: Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
Message-ID: <20030127182856.GE20701@h55p111.delphi.afb.lu.se>
References: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us> <Pine.LNX.4.44.0301270920150.5267-100000@harappa.oldtrail.reston.va.us> <20030127.101128.104592362.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030127.101128.104592362.davem@redhat.com>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18dE08-0008Eb-00*MXKiLb9U7QQ* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 10:11:28AM -0800, David S. Miller wrote:
> 
> I think the clue in this thread is the TCP_NODELAY socket option.
> The one post claimed that by turning this on in telnet, it made
> telnet exhibit the same problems SSH shows.

This is a "me too", well actually not me, but some friends is seeing this.
 If I remember correctly the data was actually sent to the server and only
the response was lost (seen be stracing the shell on the server). Someone
suggested that it might be the sequence-number beeing screwed up.


-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
