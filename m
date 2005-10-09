Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVJIH02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVJIH02 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 03:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVJIH02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 03:26:28 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:43464 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932230AbVJIH02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 03:26:28 -0400
X-Envelope-From: stefan@lucke.in-berlin.de
From: Stefan Lucke <stefan@lucke.in-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: touchkit PS/2 touchscreen driver
Date: Sun, 9 Oct 2005 09:26:24 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gYMSD5zWEOzyFiL"
Message-Id: <200510090926.24426.stefan@lucke.in-berlin.de>
X-Spam-Score: (-0.856) AWL,BAYES_05,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gYMSD5zWEOzyFiL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

based on the touchkit USB and livebook PS/2 touchscreen driver,
I made a driver for the touchkit PS/2 version. The work is based upon
kernel 2.6.13.2 .

The egalax touchsreen controller (PS/2 or USB version) is used
in this 7" device:
http://www.cartft.com/catalog/il/449

Currently I'm using the PS/2 version in a DirectFB enviroment.
http://www.directfb.org/
http://mail.directfb.org/pipermail/directfb-dev/2005-September/000705.html
http://mail.directfb.org/pipermail/directfb-dev/2005-September/000706.html


Could you please have a look at it and tell my your comments on
what would be additional required to get it included into kernel tree.

Please CC me on replies, as I'm not subscribed to this list.


-- 
Stefan Lucke

--Boundary-00=_gYMSD5zWEOzyFiL
Content-Type: application/x-bzip2;
  name="touchkit_ps2.pub01.diff.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="touchkit_ps2.pub01.diff.bz2"

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
+15RFD+LEuVcVqf+LuSKcKEguftzIg==

--Boundary-00=_gYMSD5zWEOzyFiL--

