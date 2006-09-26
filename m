Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWIZSgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWIZSgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWIZSgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 14:36:07 -0400
Received: from firewall.osb.hu ([193.224.234.1]:19116 "EHLO mail.osb.hu")
	by vger.kernel.org with ESMTP id S1751589AbWIZSgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 14:36:06 -0400
Message-ID: <4519730A.8030500@osb.hu>
Date: Tue, 26 Sep 2006 20:35:54 +0200
From: =?ISO-8859-2?Q?So=F3s_P=E9ter?= <sp@osb.hu>
Organization: Archabbey of Pannonhalma
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: rlove@rlove.org
CC: linux-kernel@vger.kernel.org
Subject: Patch for hdaps to support Lenovo ThinkPad T60
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------030501040501030403000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030501040501030403000604
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit

Hi,

I attached a trivial patch for kernel 2.6.18 to support hdaps on Lenovo
ThinkPad T60. It was tested with pivot utility comes from
http://www.kernel.org/pub/linux/kernel/people/rml/hdaps and seem to be OK.

Please apply it.

Thanks,
-- 
Soós Péter		Pannonhalmi Fõapátság / Archabbey of Pannonhalma
			H-9090 Pannonhalma, Vár 1.
			Tel: +3696570189, Fax: +3696570183

--------------030501040501030403000604
Content-Type: text/x-patch;
 name="hdaps_tpt60-2.6.18.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdaps_tpt60-2.6.18.patch"

--- ./drivers/hwmon/hdaps.c.orig	2006-09-23 21:43:04.000000000 +0200
+++ ./drivers/hwmon/hdaps.c	2006-09-23 21:44:24.000000000 +0200
@@ -537,6 +537,7 @@
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad T42"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad T43"),
 		HDAPS_DMI_MATCH_LENOVO("ThinkPad T60p"),
+		HDAPS_DMI_MATCH_LENOVO("ThinkPad T60"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X40"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41"),
 		HDAPS_DMI_MATCH_LENOVO("ThinkPad X60"),

--------------030501040501030403000604--


