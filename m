Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpBRWzzCFBNTIS+eSuirRTmeGmw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 09:11:17 +0000
Message-ID: <00c601c415a4$1456f700$d100000a@sbs2003.local>
From: "Dmitry Torokhov" <dtor_core@ameritech.net>
X-Mailer: Microsoft CDO for Exchange 2000
To: <Administrator@osdl.org>
Subject: Re: [PATCH 6/7] Kconfig Synaptics help
Date: Mon, 29 Mar 2004 16:39:53 +0100
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Content-Class: urn:content-classes:message
References: <200401030350.43437.dtor_core@ameritech.net> <200401030401.35798.dtor_core@ameritech.net> <200401030402.16745.dtor_core@ameritech.net>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
In-Reply-To: <200401030402.16745.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:53.0390 (UTC) FILETIME=[14606CE0:01C415A4]

===================================================================


ChangeSet@1.1576, 2004-01-03 02:49:55-05:00, dtor_core@ameritech.net
  Input: Kconfig help section update -
         Suggest psmouse.proto=imps option to Synaptics users who do not
         want installing native XFree driver but want tapping work


 Kconfig |    2 ++
 1 files changed, 2 insertions(+)


===================================================================



diff -Nru a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
--- a/drivers/input/mouse/Kconfig	Sat Jan  3 03:10:06 2004
+++ b/drivers/input/mouse/Kconfig	Sat Jan  3 03:10:06 2004
@@ -29,6 +29,8 @@
 	  and a new verion of GPM at:
 		http://www.geocities.com/dt_or/gpm/gpm.html
 	  to take advantage of the advanced features of the touchpad.
+	  If you do not want install specialized drivers but want tapping
+	  working please use option psmouse.proto=imps.
 
 	  If unsure, say Y.
 
