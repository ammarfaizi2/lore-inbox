Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVIJXTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVIJXTw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVIJXTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:19:52 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:60039 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932361AbVIJXTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:19:52 -0400
Message-ID: <43236A02.9070301@gmail.com>
Date: Sun, 11 Sep 2005 01:19:30 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm 1/2] drivers/char/isicom old api rewritten
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes old api in pci probing and replaces it with new.
Firmware loading added.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 drivers/char/isicom.c  | 1056 
++++++++++++++++++++++++-------------------------
 include/linux/isicom.h |   54 --
 2 files changed, 539 insertions(+), 571 deletions(-)

Patch is here for its size (40 KiB):
http://www.fi.muni.cz/~xslaby/lnx/isi_main.txt

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

