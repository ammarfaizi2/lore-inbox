Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131209AbRC0L0C>; Tue, 27 Mar 2001 06:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRC0LZw>; Tue, 27 Mar 2001 06:25:52 -0500
Received: from top.servicom2000.com ([212.101.64.178]:26534 "HELO compiler")
	by vger.kernel.org with SMTP id <S131209AbRC0LZi>;
	Tue, 27 Mar 2001 06:25:38 -0500
Date: Tue, 27 Mar 2001 13:22:02 +0200
From: Santiago Romero <sromero@servicom2000.com>
To: linux-kernel@vger.kernel.org
Subject: AMD PCnet32 driver does not compile on 2.4.x
Message-ID: <20010327132202.A17371@servicom2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi!
 Sorry for the "private" message... I'm testing some machines
 (real and virtual) under 2.4.3pre8, that have a AMD PCNET32
 ethernet driver. This cards works PERFECTLY under 2.2.x, but if
 I compile 2.4.x, I get a error on pcnet32.c about a function 
 not defined: is_valid_etherdevice(). 

 It seems that you all have changed lots of networking functions
 on the 2.2 to 2.4 change, but this driver still continues using
 the old functions.

 If i just comment the call to is_valid_etherdevice() (I'll
 assume the kernel passes a good etherdevice to pcnet32.c :-)
 the system hangs during boot when loading the pcnet32 module.

 If you need more info about this, ask me at this email.
 Thanks a lot for any help.
 
-- 
Santiago Romero
Departamento de Sistemas
sromero@servicom2000.com

C/ Primado Reig, 189 entlo
46020 Valencia - Spain
Tel. (+34) 96 332 12 00
Fax. (+34) 96 332 12 01
http://www.servicom2000.com

