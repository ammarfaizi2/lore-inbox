Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVIQPcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVIQPcd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVIQPcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:32:33 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:6295 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751122AbVIQPcc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:32:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HMw3Hx34dLangm2u4N7PBzInlze+TUSBUfhnepUZ7CJ0r58NkG/FU34awyD71IZ1KpmkJHnFzNsNZtVpnl9l34AlC2WWohEcyPZzevdmqAWrvy3CfbNE1Vqwsd1SQLEfX6SmcBU27sX+y/sNY6B1TiLslXbGUnS56fW1Ze145VI=
Message-ID: <39e6f6c705091708323259f932@mail.gmail.com>
Date: Sat, 17 Sep 2005 12:32:31 -0300
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Reply-To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Harald Welte <laforge@netfilter.org>, Roman Zippel <zippel@linux-m68k.org>,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Netdev List <netdev@vger.kernel.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [HELP] netfilter Kconfig dependency nightmare
In-Reply-To: <20050917152931.GA8413@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050916021451.3012196c.akpm@osdl.org>
	 <20050916191959.GN8413@sunbeam.de.gnumonks.org>
	 <39e6f6c705091617514457eded@mail.gmail.com>
	 <20050917012315.GA29841@mandriva.com>
	 <20050917080714.GV8413@sunbeam.de.gnumonks.org>
	 <Pine.LNX.4.61.0509171306290.3743@scrub.home>
	 <20050917112949.GZ8413@sunbeam.de.gnumonks.org>
	 <Pine.LNX.4.61.0509171407460.3743@scrub.home>
	 <20050917152931.GA8413@sunbeam.de.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/05, Harald Welte <laforge@netfilter.org> wrote:
> On Sat, Sep 17, 2005 at 02:18:28PM +0200, Roman Zippel wrote:
> > Since IP_NF_CONNTRACK_NETLINK is the one creating the dependency,
> > something like this should work:
> 
> yes, I agree.  Looking at the behaviour of "menuconfig", I think your
> suggestion solves the problem.  I didn't try to compile all the
> combinations, though.
> 
> I'll submit a patch via DaveM soon.

OK, I'll test it as soon as it appears here :-)

- Arnaldo
