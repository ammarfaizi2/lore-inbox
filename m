Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbSLRCOH>; Tue, 17 Dec 2002 21:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSLRCOH>; Tue, 17 Dec 2002 21:14:07 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:30226 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267104AbSLRCOG>; Tue, 17 Dec 2002 21:14:06 -0500
Date: Wed, 18 Dec 2002 00:21:40 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: joe user <joe_user35@hotmail.com>
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org
Subject: Re: netstat and 2.5.5[12]
Message-ID: <20021218022140.GH8824@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	joe user <joe_user35@hotmail.com>, andersg@0x63.nu,
	linux-kernel@vger.kernel.org
References: <F155vsq9IcVux1Zcn8T000004c6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F155vsq9IcVux1Zcn8T000004c6@hotmail.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 18, 2002 at 02:27:46AM +0100, joe user escreveu:
> 
> >Em Mon, Dec 16, 2002 at 01:45:53PM +0100, Anders Gustafsson escreveu:
> >> On Mon, Dec 16, 2002 at 01:06:32PM +0100, joe user wrote:
> >> > Is required a new net-tools package required to run 2.5.5[12]? If you 
> >run
> >> > netstat -t the process just hang forever, and is unkillable.
> >>
> >> Happens here too.
> >> http://marc.theaimsgroup.com/?l=linux-kernel&m=103974450111945&w=2
> >>
> >> A cat /proc/net/tcp causes the same problem, so not tools problem.
> >
> >I'm looking into this, do you have ipv6 connections?
> 
> I have ipv6 support compiled in but no ipv6 connections at all that I'm 
> aware of. This is a fresh install of redhat8 running X and several rpc 
> daemons: rstatd, rusersd, rwalld. I'm running sshd and rwhod too. Not sure 
> if any of these daemons are compiled with ipv6 support.

Probably yes, listening seems to be enough, thanks for the report.

- Arnaldo
