Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUJSBnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUJSBnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUJSBnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:43:52 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:53687 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268265AbUJSBnp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:43:45 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue,_19_Oct_2004_01_43_36_+0000_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20041019014336.9460AC2558@merlin.emma.line.org>
Date: Tue, 19 Oct 2004 03:43:36 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.232, 2004-10-19 03:43:09+02:00, matthias.andree@gmx.de
  Support blanks and underscores as word separators in Signed-off-by: tags.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

##### GNUPATCH #####
--- 1.203/shortlog	2004-10-14 08:58:06 +02:00
+++ 1.204/shortlog	2004-10-19 03:43:09 +02:00
@@ -2947,7 +2947,7 @@
       } else {
 	  print STDERR " SKIPPED FROM  $author\n" if $debug;
       }
-    } elsif (/^\s+Signed-off-by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
+    } elsif (/^\s+Signed[- _]off[- _]by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
       my @nameauthor = treat_address($1, $2);
       if ($namepref < 0) {
 	  ($name, $address, $author) = @nameauthor;



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAEdxdEECA82UXU/bMBSGr+tfcVR2AUVJbCdpPrRCB0wbYtJQEVcUJic5baMmcWW7Bbbs
v8+lA0SlXYxxMceSdezj+D2vH3kHTk/SjpFqJapCDxfYTJdl4xolGl2jEW4u6/Z4JpopXqBp
OaXcfoz7tB8mLU/6YdgixzDMAyayKI4w52QHLjWqtFMLY2al0K5oCoVo5z9LbdLOtL5zi3U4
ktKG3kooLyvNHHGByjs6c+aoGqwcI2Wlic07FyafwQqVTjvM9Z9mzP0C087o46fLLx9GhAwG
8CQVBgPyxmVpUWM1rEVZufn3l7sDRllg98Z+1PZDHvfJCTCX+xxo4DHqsQSonwZ+SpN9ylNK
Ycub4cYT2GfgUHIEbyz9mORwsVwspDKQVaKZa7DnwrIprKe5VGhjDbdSFaBxIZSw52soG7go
pw0WjpxMnOw+BSOm2iVn0PcTcv5sNnH+shFCBSUHz2XOZI1bNeqZVVvJ6abEkMU0CiIWtz6L
krCdYCImeUQTQbEQWfEHQ1/8ZX1Lib0on1qjeMyiB2QeM14Q8896tmjZlvEAC+1bGSwJN7DQ
4DWwsP8flo3VX8FRt3fr7txZdh4NeQU6JzwJKTBy+nsE234CVrqcwK53M9b7GyFXDny7tmIe
RitorHvdw92rm+51b697aNPG73fd3t74wC6888o9+PH81uQzzOd6WQ9iwbKQZwn5BeOzdTQq
BQAA

