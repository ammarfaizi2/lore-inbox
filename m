Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319216AbSIDQSh>; Wed, 4 Sep 2002 12:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319221AbSIDQSh>; Wed, 4 Sep 2002 12:18:37 -0400
Received: from orion.netbank.com.br.199.203.200.in-addr.arpa ([200.203.199.90]:18950
	"EHLO orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S319216AbSIDQSg>; Wed, 4 Sep 2002 12:18:36 -0400
Date: Wed, 4 Sep 2002 13:23:09 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: X.25 Support in Kernel?
Message-ID: <20020904162309.GI4427@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
References: <al4ihm$h34$1@forge.intermeta.de> <20020904155042.GA4427@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020904155042.GA4427@conectiva.com.br>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 04, 2002 at 12:50:43PM -0300, Arnaldo C. Melo escreveu:
> Em Wed, Sep 04, 2002 at 09:08:06AM +0000, Henning P. Schmiedehausen escreveu:
 
> Maybe adapting the XOT code to do userspace X.25 over a PF_LLC socket could
> do it :)

On this path you can take a look at the code Jay is working on, supporting
DLSw in userlevel, using PF_LLC sockets.

Hey, I'm even considering making NetBEUI a userlevel implementation after I
finish the restructuring of PF_LLC/core wrt using only one struct sock for
easier locking and for it to look more like the tcp codepaths (not including
the state machine, of course ;) ).

- Arnaldo
