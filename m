Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSGST2D>; Fri, 19 Jul 2002 15:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316965AbSGST2D>; Fri, 19 Jul 2002 15:28:03 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26375 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315595AbSGST2C>; Fri, 19 Jul 2002 15:28:02 -0400
Date: Fri, 19 Jul 2002 16:30:59 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: "Patrick J. LoPresti" <patl@curl.com>,
       Joseph Malicki <jmalicki@starbak.net>, linux-kernel@vger.kernel.org
Subject: Re: close return value
Message-ID: <20020719193059.GD2718@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Lars Marowsky-Bree <lmb@suse.de>,
	"Patrick J. LoPresti" <patl@curl.com>,
	Joseph Malicki <jmalicki@starbak.net>, linux-kernel@vger.kernel.org
References: <200207182347.g6INlcl47289@saturn.cs.uml.edu> <s5gsn2fr922.fsf@egghead.curl.com> <015401c22f40$c4471380$da5b903f@starbak.net> <s5gvg7bmu43.fsf@egghead.curl.com> <20020719192524.GY12420@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719192524.GY12420@marowsky-bree.de>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 19, 2002 at 09:25:24PM +0200, Lars Marowsky-Bree escreveu:
> On 2002-07-19T14:48:44,
>    "Patrick J. LoPresti" <patl@curl.com> said:
> 
> > Of course, checking errors in order to handle them sanely is a good
> > thing.  Nobody is arguing that.  What I am arguing is that failing to
> > check errors when they can "never happen" is wrong.
> 
> Actually, checking for _all_ even remotely possible and checkable error
> conditions (if the check doesn't incur an intolerable overhead) is a very very
> important requirement for writing high quality code; even if it isn't "fault

If the function is not to be checked for errors, lets make it return void and
be done with it. There are few _exceptions_, but one has to understand the
meaning of that word 8)

- Arnaldo
