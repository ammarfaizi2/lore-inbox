Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVDZP2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVDZP2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVDZP2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:28:50 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:44847 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261599AbVDZP13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:27:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=REnufFmAz/1eVLsJJZ925wO04s4TORvD20MXBC8LL/lDgIeqNB9V+nXc+exudUnezrKCLjKw9JLbL7Z3tLN5B1t039gNuXYUO3Xuaoj/JAm65nCMYS+vHOxklM2NB3pRohiBx9cvLBtAjFmY4SO5QaZZBsBG8iXPHtC9c2wU22k=
Message-ID: <426E5C44.2060002@gmail.com>
Date: Tue, 26 Apr 2005 11:20:36 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] do_mounts.c: Minor ROOT_DEV comment cleanup
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ROOT_DEV comment is no longer accurate, it now seems to be 
initialized in init/do_mounts.c.


Signed-off-by: Florin Malita <fmalita@gmail.com>

--- linux-2.6.12-rc3/init/do_mounts.c   2005-04-20 20:03:16 -0400
+++ linux/init/do_mounts.c      2005-04-26 10:23:39 -0400
@@ -22,7 +22,6 @@
  char * __initdata root_device_name;
  static char __initdata saved_root_name[64];

-/* this is initialized in init/main.c */
  dev_t ROOT_DEV;

  EXPORT_SYMBOL(ROOT_DEV);
