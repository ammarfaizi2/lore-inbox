Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSKCSVq>; Sun, 3 Nov 2002 13:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbSKCSVq>; Sun, 3 Nov 2002 13:21:46 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:2567 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262289AbSKCSVp>;
	Sun, 3 Nov 2002 13:21:45 -0500
Date: Sun, 3 Nov 2002 19:28:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5: troubles with piping make output
Message-ID: <20021103182805.GA1057@mars.ravnborg.org>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Roman Zippel <zippel@linux-m68k.org>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	linux-kernel@vger.kernel.org
References: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 02:14:35PM -0200, Denis Vlasenko wrote:
> My favorite way of running make is
> 
> make "$@" 2>&1 | tee --append !make.log
> 
> but in 2.5.45 it does not work. Removing '| tee ...'
> part fixes it, but I'd like to retain the old way
> for obvious reasons.
Well, works for me, except that bash dislike '!'.

Could you try to dig a little furhter.
There were quite a lot of changes from 2.44 -> 2.45 but I cannot see
piping should be affected.

	Sam
