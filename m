Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbSALD00>; Fri, 11 Jan 2002 22:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284180AbSALD0P>; Fri, 11 Jan 2002 22:26:15 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:16648 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284138AbSALD0E>;
	Fri, 11 Jan 2002 22:26:04 -0500
Date: Sat, 12 Jan 2002 01:26:01 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Brian Litzinger <brian@top.worldcontrol.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: CIPE vs. GPLONLY_
Message-ID: <20020112032601.GA13389@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Brian Litzinger <brian@top.worldcontrol.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020112010317.GA1765@top.worldcontrol.com> <E16PD12-0000wY-00@the-village.bc.nu> <20020112014830.GA6031@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020112014830.GA6031@top.worldcontrol.com>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 11, 2002 at 05:48:30PM -0800, brian@worldcontrol.com escreveu:
> On Sat, Jan 12, 2002 at 01:31:24AM +0000, Alan Cox wrote:
> > > running CIPE 1.5.2 I get the error above.  Should I be bother the
> > > CIPE people with this?  Or is this some kernel thingy that needs
> > > to be dealt with?
> > Add
> > 	MODULE_LICENSE("GPL");
> > to the cipe code and all will be well
> 
> Thanks. I added that and now I'm just left with sk_run_filter
> undef'ed without the GPLONLY_ warning.
> 
> I've deleted my kernel sources and am starting everything over
> from scratch.  I checked that 'CONFIG_FILTER' was defined
> and all seemed in order, but still got the error.
> 
> I read through the last few months of the CIPE archives and there
> is no mention of such a problem.  Others mention running with
> 2.4.17, hence my start over.

probably because they use an old modutils package...

- Arnaldo
