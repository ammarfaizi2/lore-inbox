Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131332AbRASNCV>; Fri, 19 Jan 2001 08:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbRASNCM>; Fri, 19 Jan 2001 08:02:12 -0500
Received: from galileo.bork.org ([209.217.122.37]:48392 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id <S131332AbRASNCE>;
	Fri, 19 Jan 2001 08:02:04 -0500
Subject: Re: pppoe in 2.4.0
From: Martin Hicks <mort@bork.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200101190610.f0J6AUK05724@caliban.org>
In-Reply-To: <E14JRYM-0000Ns-00@plato.bork.org>  
	<200101190610.f0J6AUK05724@caliban.org>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 19 Jan 2001 08:00:40 -0500
Mime-Version: 1.0
Message-Id: <E14Jb9l-0000j4-00@plato.bork.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you all.  I was silly and didn't create the /dev/ppp device.

On 19 Jan 2001 07:10:30 +0100, Ian Macdonald wrote:
> On 19 Jan 2001 03:51:20 +0100 in caliban.linux.kernel, you wrote:
> 
> >Does anyone have pppoe working with 2.4.0?
> >
> >I'm running 2.4.0-ac9 with ppp and pppoe compiled into the kernel (I've
> >tried with modules too)
> >
> >The pppd simply refuses to acknowlege the presence of ppp support in the
> >kernel.
> >The last release of pppd was in august 2000.  Was this before the ppp
> >interface in the 
> >kernel was overhauled?
> 
> Have you aliased the new module name to ppp?
> 
> I'm using pppd just for simple dial-up from home, but I needed to add
> the following line to /etc/modules.conf before pppd would load the
> correct module:
> 
> alias ppp ppp_async
> 
> However, I couldn't get PPP to work when I compiled it directly into
> the kernel.
> 
> Ian
> -- 
> Ian Macdonald               | "Language shapes the way we think, and     
> Senior System Administrator | determines what we can think about." -- B. 
> Linuxcare, Inc.             | L. Whorf                                   
> Support for the Revolution  |                                            
>                             |                                            
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/



-- 
Martin Hicks   || mort@bork.org    
Use PGP/GnuPG  || DSS PGP Key: 0x4C7F2BEE  
Beer: So much more than just a breakfast drink.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
