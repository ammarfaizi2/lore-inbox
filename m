Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313007AbSC0RET>; Wed, 27 Mar 2002 12:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313054AbSC0REK>; Wed, 27 Mar 2002 12:04:10 -0500
Received: from [206.11.169.19] ([206.11.169.19]:10248 "EHLO wind.enjellic.com")
	by vger.kernel.org with ESMTP id <S313007AbSC0RDv>;
	Wed, 27 Mar 2002 12:03:51 -0500
Message-Id: <200203271703.g2RH3VGg015233@wind.enjellic.com>
From: greg@wind.enjellic.com (Dr. Greg Wettstein)
Date: Wed, 27 Mar 2002 11:03:31 -0600
In-Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
       "Re: Hamachi driver dead in 2.4.18." (Mar 27,  4:09pm)
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: vda@port.imtp.ilyichevsk.odessa.ua, greg@enjellic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Hamachi driver dead in 2.4.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 27,  4:09pm, vda@port.imtp.ilyichevsk.odessa.ua wrote:
} Subject: Re: Hamachi driver dead in 2.4.18.

> On 27 March 2002 11:47, Dr. Greg Wettstein wrote:
> > Good morning to everyone.
> >
> > We are in the process of upgrading our computational clusters to
> > 2.4.18 and have run into reasonably stubborn problems with the GNIC-II
> > driver (hamachi.c).  Transmitting *seems* to be fine but the card
> > refuses to receive.  We instead get receive errors flagged in the
> > /sbin/ifconfig list for the interface for each packet that should have
> > been received.
> 
> What was previous kernel version?

The clusters are running 2.2.18 right now compiled with egcs-2.91.66
with no problems.

> > The kernel was compiled with egcs-2.91.66.  The same compiler
> > generates a 2.2.x kernel which seems to work just fine.
> 
> Consider trying with newer gcc.

I will give that a try although it doesn't seem to smell like a
compiler problem to me.  Its worth a shot though.

> vda

Greg

}-- End of excerpt from vda@port.imtp.ilyichevsk.odessa.ua

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-4950            WWW: http://www.enjellic.com
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"69k... I remember when we had a punch card machine and had to send them
off to the University of London where this bloke looked at them and then
sent them back with "You've missed a semicolon on line ten" written on it.
Them wert days."
                                -- Michael Ashton
