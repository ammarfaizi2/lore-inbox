Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136127AbREDLBs>; Fri, 4 May 2001 07:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136156AbREDLBi>; Fri, 4 May 2001 07:01:38 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:5073 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S136127AbREDLBZ>; Fri, 4 May 2001 07:01:25 -0400
Message-ID: <3AF28C11.AD4528F7@TeraPort.de>
Date: Fri, 04 May 2001 13:01:37 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcmcia problems after upgrading from 2.4.3-ac7 to 2.4.4
In-Reply-To: <E14vFZb-0005GA-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------8FA7973417DE1B51EBEE9B9D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8FA7973417DE1B51EBEE9B9D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> >  my DE-620 pccard stopped working after upgrading the kernel from
> > 2.4.3-ac7 to 2.4.4. This is on a Toshiba 4080XCDT. I used the "good"
> > .config from the 2.4.3-ac7 build to do a make "oldconfig". The symptoms
> > at startup are:
> 
> 2.4.4 has older pcmcia than 2.4.3-ac7. It might be that. Does 2.4.4-ac work ?

 just some additional info. The card actually stopped working in
2.4.3-a11 upwards with the same symptoms as in my original request.

 2.4.3-ac9 is the last working one. Not sure about -ac10, because that
one crashes during boot (not related to pcmcia as far as I can
remember). So, what was added in ac11 or ac10 that could hurt pcmcia or
the i82365 module?

 I'll now try 2.4.4-ac4.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------8FA7973417DE1B51EBEE9B9D
Content-Type: text/x-vcard; charset=us-ascii;
 name="Martin.Knoblauch.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Martin.Knoblauch
Content-Disposition: attachment;
 filename="Martin.Knoblauch.vcf"

begin:vcard 
n:Knoblauch;Martin
tel;cell:+49-170-4904759
tel;fax:+49-89-510857-111
tel;work:+49-89-510857-309
x-mozilla-html:FALSE
url:http://www.teraport.de
org:TeraPort GmbH;IT-Services
adr:;;Garmischer Straße 4;München;Bayern;D-80339;Germany
version:2.1
email;internet:Martin.Knoblauch@TeraPort.de
title:Senior System Engineer
x-mozilla-cpt:;32160
fn:Martin Knoblauch
end:vcard

--------------8FA7973417DE1B51EBEE9B9D--

