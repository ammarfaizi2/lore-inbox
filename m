Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTJMMaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTJMMaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:30:13 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:20977 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S261722AbTJMMaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:30:06 -0400
Message-ID: <3F8A9A5F.8060300@superonline.com>
Date: Mon, 13 Oct 2003 15:28:15 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre7-pac1
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;

What is the point of this hunk?

--- linux-2.4.23-pre7/drivers/char/Config.in	2003-10-12 14:32:33.000000000 +0200
+++ linux-2.4.23-pre7-pac1/drivers/char/Config.in	2003-10-12 15:31:44.000000000 +0200
[...]
@@ -349,6 +352,7 @@
       define_bool CONFIG_DRM_NEW y
       source drivers/char/drm/Config.in
    fi
+   bool '  ATI IGP chipset support' CONFIG_AGP_ATI
 fi
 endmenu

OTOH, CONFIG_DRM_GAMMA, CONFIG_DRM_S3 and CONFIG_DRM_VIA are not
present, while they were available in 22-ac4. This is the first time
I'm messing with 23-preX and it seems like somethings have changed?

Regards,
Özkan Sezer

