Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267231AbSKPGRQ>; Sat, 16 Nov 2002 01:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267232AbSKPGRQ>; Sat, 16 Nov 2002 01:17:16 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:49927 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267231AbSKPGRO>; Sat, 16 Nov 2002 01:17:14 -0500
Date: Sat, 16 Nov 2002 04:23:44 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Dan Kegel <dank@kegel.com>
Cc: john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
Message-ID: <20021116062344.GM16673@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Dan Kegel <dank@kegel.com>, john slee <indigoid@higherplane.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DD5D93F.8070505@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD5D93F.8070505@kegel.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 15, 2002 at 09:35:59PM -0800, Dan Kegel escreveu:
> john slee <indigoid@higherplane.net> wrote:
> >On Thu, Nov 14, 2002 at 10:58:09PM -0500, Patrick Finnegan wrote:
> >>It'd be nice if people simply tried compiling a patched kernel (all
> >>affected modules) before they submitted the patch, I'm betting you'd catch
> >>a lot of typos.  Also, compiling _everything_, even as a module, at
> >>least once before sumbitting the patch would probably help.

> >thats fine if there is an all-compiling kernel release out there.  right
> >now 2.5-bk is far from it.  last i checked allmodconfig (a couple of
> >days ago) there was major breakage all over llc, scsi, video, sound, ...
> >which kinda masks any breakages you might have introduced. 

> Hrmph.  Y'know, maybe it's time for us to collectively put our
> feet down, get 2.5-linus to the point where everything compiles,
> and keep it there.  After all, we are supposedly trying to
> *stabilize* 2.5.  It isn't stable if it doesn't compile...

mmkay, I'm working on the "missing symbols problems with llc in allmodconfig"
But cli/sti will take some more time, I think.

- Arnaldo
