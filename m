Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbRENGhv>; Mon, 14 May 2001 02:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbRENGhl>; Mon, 14 May 2001 02:37:41 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:29889 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S262196AbRENGhX>; Mon, 14 May 2001 02:37:23 -0400
Message-ID: <3AFF7D39.3FDD4144@TeraPort.de>
Date: Mon, 14 May 2001 08:37:45 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Size of /proc/kcore growing over time ?
In-Reply-To: <3AFBE5BF.5865B0CA@TeraPort.de> <20010512003534.A1060@werewolf.able.es>
Content-Type: multipart/mixed;
 boundary="------------071890BD94909C5D37DA8DDE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------071890BD94909C5D37DA8DDE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"J . A . Magallon" wrote:
> 
> On 05.11 Martin.Knoblauch wrote:
> >
> >  I ask, because I thought the size of kproc could be used to determine
> > the amount of physical memory. If this assumption is wrong, is there
> > another way to achive the goal?
> >
> 
> #include <sys/sysinfo.h> // for get_phys_pages()
> #include <unistd.h> // for getpagesize()
> 
> ram = get_phys_pages()*getpagesize();
> 

 Close, but not there :-) What I want is the total physical memory in
the system. Above seems to report only the physical pages available to
the kernel.

Thanks anyway
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
IT Services              |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------071890BD94909C5D37DA8DDE
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

--------------071890BD94909C5D37DA8DDE--

