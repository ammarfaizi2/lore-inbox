Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbRF1Snq>; Thu, 28 Jun 2001 14:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbRF1Sng>; Thu, 28 Jun 2001 14:43:36 -0400
Received: from imladris.infradead.org ([194.205.184.45]:40967 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S262116AbRF1Sn0>;
	Thu, 28 Jun 2001 14:43:26 -0400
Date: Thu, 28 Jun 2001 19:43:09 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Config variable scripts
Message-ID: <Pine.LNX.4.33.0106281938380.12626-101000@infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-842912328-1033931903-993753789=:12626"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---842912328-1033931903-993753789=:12626
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Alan.

The enclosed patch was originally developed for the ELKS kernel, but
will apply equally well against any Linux kernel as it only adds new
scripts to the scripts subdirectory. The new scripts are as follows:

 1. renvar	Renames configuration variables in all files
		they occur in in the entire source tree.

 2. varlist	Lists all configuration variables currently
		in use, together with the number of files
		in which they occur.

Can you apply this against both the 2.2 and 2.4 trees please?

Best wishes from Riley.

---842912328-1033931903-993753789=:12626
Content-Type: APPLICATION/x-gzip; name="elks-0.0.84-vars.diff.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0106281943090.12626@infradead.org>
Content-Description: Config variable scripts
Content-Disposition: attachment; filename="elks-0.0.84-vars.diff.gz"

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
VHgcIeup/wedE90y+BEAAA==
---842912328-1033931903-993753789=:12626--
