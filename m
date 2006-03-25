Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751969AbWCYXgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbWCYXgL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 18:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbWCYXgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 18:36:11 -0500
Received: from outgoing2.smtp.agnat.pl ([193.239.44.84]:33032 "EHLO
	outgoing2.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1751969AbWCYXgK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 18:36:10 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: patch : hdaps on Thinkpad R52
Date: Sun, 26 Mar 2006 00:35:59 +0100
User-Agent: KMail/1.9.1
References: <20060314205758.GA9229@gevaerts.be> <20060325210946.GZ4053@stusta.de>
In-Reply-To: <20060325210946.GZ4053@stusta.de>
Cc: rlove@rlove.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603260035.59316.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 March 2006 22:09, you wrote:
> On Tue, Mar 14, 2006 at 09:57:58PM +0100, Frank Gevaerts wrote:
> > Hello,
>
> Hi Frank,
>
> > I had to add a new entry to the hdaps_whitelist table in hdaps.c to get
> > my Thinkpad R52 recognized. Patch is attached
>
> please resend your patch:
> - inline in the email (not an attachment) and
> - with a Signed-off-by: line

Here is a patch for Z60m. hdaps seems working fine - pivot utility reports values
that match description by R. Love sent to this ml few months ago.

Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>

--- linux-2.6.16/drivers/hwmon/hdaps.c.org	2006-03-26 00:30:53.000000000 +0100
+++ linux-2.6.16/drivers/hwmon/hdaps.c	2006-03-26 00:31:30.000000000 +0100
@@ -528,6 +528,7 @@
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X40"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41 Tablet"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41"),
+		HDAPS_DMI_MATCH_NORMAL("ThinkPad Z60m"),
 		{ .ident = NULL }
 	};
 

>
> > Frank
>
> TIA
> Adrian

-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
