Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289589AbSAPWA7>; Wed, 16 Jan 2002 17:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289568AbSAPWAv>; Wed, 16 Jan 2002 17:00:51 -0500
Received: from cpe.atm2-0-105125.0x3ef2066b.hrnxx2.customer.tele.dk ([62.242.6.107]:31099
	"HELO mars.ravnborg.org") by vger.kernel.org with SMTP
	id <S289833AbSAPWAc>; Wed, 16 Jan 2002 17:00:32 -0500
Date: Wed, 16 Jan 2002 23:01:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ISDN CHANNEL-D
Message-ID: <20020116230131.B2236@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <001d01c19ec5$b6f8f740$d500a8c0@mshome.net> <3C45E95A.2010802@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C45E95A.2010802@antefacto.com>; from padraig@antefacto.com on Wed, Jan 16, 2002 at 08:58:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 08:58:02PM +0000, Padraig Brady wrote:
> AstinusLists wrote:
> 
> > Hello every one.
> > 
> > I've been earing some rumors, that i am quite sure that are turth about the
> > isdn channel d.
> > 
> > As all of u know ( i think ) isdn cards have 3 channels: 2*64 and one time
> > 16 kbs.
> > 
> > This last one is called channel D.
> > Channel D is used to dial and to reply to tones and minor stuff like that.
> 
> Yes info is passed across the D channel in messages. There is a message
> 
> type called User User information that can be passed, but only with and
> associated D channel call type, i.e. you must pay for it.

What the original author refer to is utilising the D-Channel to support
LAPB/X.25 traffic. This is done using a special SAPI=16 value.
I dunno if the ISDN drivers in Linux support this yet.

Charging for the above is operator specific, when I worked with this in the past
the charging was unrealistic high.

	Sam 
