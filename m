Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132922AbREGJOt>; Mon, 7 May 2001 05:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135810AbREGJOk>; Mon, 7 May 2001 05:14:40 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:57286 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S132922AbREGJOg>; Mon, 7 May 2001 05:14:36 -0400
Message-ID: <3AF66787.55452CCF@TeraPort.de>
Date: Mon, 07 May 2001 11:14:47 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [Solved ?] Re: pcmcia problems after upgrading from 2.4.3-ac7 to 
 2.4.4
In-Reply-To: <3AF65FB3.777461BA@TeraPort.de>  <E14vFZb-0005GA-00@the-village.bc.nu> <1870.989225880@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------0CE6602A05CD40C08BCB15A4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0CE6602A05CD40C08BCB15A4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

David Woodhouse wrote:
> 
> Martin.Knoblauch@TeraPort.de said:
> >
> >   I am not sure whether this should be closed alltogether. Maybe
> > i82365 was not the proper choice for my hardware in the first place.
> > Anyway, the module seems to be retired as of 2.4.3-ac10/ac11. Maybe a
> > hint should go into the changes document.
> 
> i82365 is for use only on PCMCIA bridges, not CardBus. It should not be
> 'retired' but should probably have the config option renamed to prevent
> confusion.
> 

 good idea. maybe the token "bridge" should appear in both the Cardbus
and PCMCIA case. It *may* have brought me on track a bit earlier :-)

 It was also confusing, that the i82365 module worked [for me]
until/including 2.4.3-ac9.

 Anyway, the story just shows that reading the docs helps from time to
time. :-)

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------0CE6602A05CD40C08BCB15A4
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

--------------0CE6602A05CD40C08BCB15A4--

