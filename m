Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSFILCv>; Sun, 9 Jun 2002 07:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317599AbSFILCu>; Sun, 9 Jun 2002 07:02:50 -0400
Received: from [62.65.151.174] ([62.65.151.174]:37580 "EHLO zeus")
	by vger.kernel.org with ESMTP id <S317597AbSFILCu>;
	Sun, 9 Jun 2002 07:02:50 -0400
Date: Sun, 9 Jun 2002 12:44:08 +0200
From: Mathias Gygax <mg@trash.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ip_nat_irc & 2.4.18
Message-ID: <20020609104408.GB1036@chiba.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <1023530798.29159.2.camel@tux> <1023589926.8435.1.camel@tux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2002 at 10:32:06PM -0400, Nix N. Nix wrote:
> ip_nat_irc.o doesn't track connection going to ports other than 6667. 
> So, if, initially, you connect to, say, twisted.ma.us.dal.net:6668, then
> ip_nat_irc doesn't track your connection. :o(

insmod ip_nat_irc ports=6667,6668,6669,7000 (etcetera)
