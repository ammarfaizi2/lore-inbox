Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282963AbRL0Wvm>; Thu, 27 Dec 2001 17:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282976AbRL0Wvc>; Thu, 27 Dec 2001 17:51:32 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28680 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282963AbRL0WvP>;
	Thu, 27 Dec 2001 17:51:15 -0500
Date: Thu, 27 Dec 2001 20:51:41 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Dave Jones <davej@suse.de>
Cc: Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Message-ID: <20011227205141.C30930@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Dave Jones <davej@suse.de>, Steven Walter <srwalter@yahoo.com>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20011227202345.B30930@conectiva.com.br> <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 27, 2001 at 11:44:12PM +0100, Dave Jones escreveu:
> On Thu, 27 Dec 2001, Arnaldo Carvalho de Melo wrote:
> 
> > > Patch is against kernel 2.4.17, should apply to 2.5 as well.
> > Good job! But please consider splitting the patch per driver and sending it
> > to the respective maintainers.
> 
> Someone with far too much time on their hands would be my personal
> hero[*] if they were to write a script (in language of their choice) to
> parse a diff, extract filename, and do lookup in a flat text file
> to find a list of maintainers/interested parties.

Humm, wouldn't it be the case to update MAINTAINERS? Or having something
like another file INTERESTED or other better name with addresses of the
right person/mailing list to send patches to?

But I like the idea of a web interface so that people interested in
specific drivers/files could register and receive it when patches are
submitted, maybe this can be coupled with the patchbot idea, that would
lookup this database (plain text file, don't worry) and send the message to
the interested people.

/me thinks... I think we have this in our linux distribution buildsystem,
for people to register interest in particular packages, but that may well
be coupled with bugzilla, and that would be too much for this simple
system... ok, I'll look into this with the distro folks here.

- Arnaldo
