Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276135AbRKICnE>; Thu, 8 Nov 2001 21:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276877AbRKICmy>; Thu, 8 Nov 2001 21:42:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41118 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S276135AbRKICmn>; Thu, 8 Nov 2001 21:42:43 -0500
Message-ID: <3BEB4299.C41D414D@ec.gc.ca>
Date: Thu, 08 Nov 2001 21:42:33 -0500
From: Michel Valin <michel.valin@ec.gc.ca>
Organization: RPN
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem with kernel 2.4.14  drivers/block/loop.c mm/swap.c
Content-Type: multipart/mixed;
 boundary="------------916C414A1D0B79932380541F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------916C414A1D0B79932380541F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


drivers/block/loop.c used by loopback filesystem code uses function

deactivate_page that was defined in mm/swap.c in kernel 2.4.13

deactivate_page seems to have been suppressed at kernel level 2.4.14
from
mm/swap.c

this results in missing entry point complaints when trying to load
module loop.o
at kernel level 2.4.14

I am not knowledgeable about these modules and am not sure if or how
loop.c and/or swap.c should be fixed

I could not find any other place to report theses findings either.

hoping that you can forward this to the proper person.

-- 
M.Valin
Recherche en Prevision Numerique
Michel.Valin@ec.gc.CA
(514) 421-4753
--------------916C414A1D0B79932380541F
Content-Type: text/x-vcard; charset=us-ascii;
 name="michel.valin.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Michel Valin
Content-Disposition: attachment;
 filename="michel.valin.vcf"

begin:vcard 
n:Valin;Michel
x-mozilla-html:FALSE
org:R.P.N.;Environnement Canada
adr:;;;;;;
version:2.1
email;internet:michel.valin@ec.gc.ca
title:Analyste Principal / Senior Analyst
x-mozilla-cpt:;0
fn:Michel Valin
end:vcard

--------------916C414A1D0B79932380541F--

