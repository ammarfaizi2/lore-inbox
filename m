Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263963AbRFHLX4>; Fri, 8 Jun 2001 07:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263964AbRFHLXq>; Fri, 8 Jun 2001 07:23:46 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:47573 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S263963AbRFHLXf>; Fri, 8 Jun 2001 07:23:35 -0400
Message-ID: <3B20B5B1.D659489F@TeraPort.de>
Date: Fri, 08 Jun 2001 13:23:29 +0200
From: "Martin.Knoblauch" <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: VM: Buffer vs. Cache
Content-Type: multipart/mixed;
 boundary="------------3C0B59EF18E1D59704E2F57B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3C0B59EF18E1D59704E2F57B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

 just being curious. Since 2.4.4, I am watching my systems memory
behaviour a bit:-) Just recently I realized the following: in the
evening I leave my 128MB system at about 20 MB, 2 MB Buffered and 100 MB
Cached (plus som 40 MB unneccesary swap :-)). When I come back in the
morning, Used is still at 20 MB (a bit down maybe) but Buffered is 50 MB
and Cached is 55 MB. For a few minutes the system is definitely more
sluggish than in the evening. Something I can excuse before my first cup
of coffe anyway...

 So, what actually is the difference between Buffered and Cached.
Apparently quite a lot of the pages that are Cached in the evening are
Buffered 9 houres later.

Thanks
Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------3C0B59EF18E1D59704E2F57B
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
org:TeraPort GmbH;C+ITS
adr:;;Garmischer Straße 4;München;Bayern;D-80339;Germany
version:2.1
email;internet:Martin.Knoblauch@TeraPort.de
title:Senior System Engineer
x-mozilla-cpt:;-7008
fn:Martin Knoblauch
end:vcard

--------------3C0B59EF18E1D59704E2F57B--

