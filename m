Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpKgTbUNoB/XQROqesYyWoYYa6g==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 06:08:59 +0000
Message-ID: <02c301c415a4$a815b030$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@osdl.org>
Subject: Re: New set of input patches
Date: Mon, 29 Mar 2004 16:44:01 +0100
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
References: <200401030350.43437.dtor_core@ameritech.net>
In-Reply-To: <200401030350.43437.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:44:01.0218 (UTC) FILETIME=[A817FA20:01C415A4]

I made 3 more input patches:

- compile fix in 98busmose driver (it still had its interrupt routine
  returning voooid instead of irqreturn_t)
- the rest of mouse devices converted to the new way of handling kernel
  parameters and document them in kernel-parametes.txt
- convert tsdev module to the new way of handling kernel parameters and
  document them in kernle-parameters.txt.

The patches can be found at the following addresses:
http://www.geocities.com/dt_or/input/2_6_1-rc1/
http://www.geocities.com/dt_or/input/2_6_1-rc1-mm1/

Vojtech, Andrew,

are you interested in these kind of patches and should I take a stab at
converting joysticks diectory as well?

Dmitry
