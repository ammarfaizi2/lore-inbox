Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSBUXqI>; Thu, 21 Feb 2002 18:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSBUXp7>; Thu, 21 Feb 2002 18:45:59 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:55786 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S287946AbSBUXps>;
	Thu, 21 Feb 2002 18:45:48 -0500
Date: Thu, 21 Feb 2002 00:45:59 +0100
From: Jose Luis Domingo Lopez <jdomingo@internautas.org>
To: Harald Welte <laforge@gnumonks.org>, linux-kernel@vger.kernel.org,
        netfilter-devel@lists.samba.org
Subject: Re: [netfilter]: FTP connection tracking problem
Message-ID: <20020220234559.GA870@localhost>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
In-Reply-To: <20020212221239.GB2161@localhost> <20020213143359.P24781@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020213143359.P24781@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 13 February 2002, at 14:33:59 +0100,
Harald Welte wrote:

> On Tue, Feb 12, 2002 at 11:12:39PM +0100, Jose Luis Domingo Lopez wrote:
> 
> > The strange part is that this will show up with just some FTP clients
> > and/or remote FTP servers. For example, text-mode web browser "links"
> > doesn't work in any case. On the other hand, text-mode browser "lynx"
> > works nice in the same places where "links" fails. "wget", "ftp" and
> > "ncftp" show various degrees of success with several combinations of
> > active/passive transfer mode and remote FTP servers (tried with
> > ftp.kernel.org, ftp.at.kernel.org, ftp.mozilla.org, ftp.rediris.es,
> > ftp.sourceforge.net).
> 
The NAT/router box that seemed to have problems with FTP connection
tracking went into production a week ago. Since them it has been working
OK, at least there are no reports froms people on the internal network
complaining about their file downloads stalling or failing.

However, most of the users don't use the net heavily. I use the net a
lot every day, and have had no big problems so far, except from some
(random) combinations of browser and remote FTP server that make
directory listing not complete (although file downloads work OK).

So it seems the problem I was having was somewhere outside the linux
kernel inside the router. Sorry for any inconvenience :-)

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

