Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRLUMY1>; Fri, 21 Dec 2001 07:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280836AbRLUMYS>; Fri, 21 Dec 2001 07:24:18 -0500
Received: from gherkin.frus.com ([192.158.254.49]:34945 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S280825AbRLUMYG>;
	Fri, 21 Dec 2001 07:24:06 -0500
Message-Id: <m16HOib-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: sr: unaligned transfer
To: linux-kernel@vger.kernel.org
Date: Fri, 21 Dec 2001 06:24:05 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone else seeing this?  With kernel version 2.5.1, I get several
instances of 

	sr: unaligned transfer

followed by

	Unable to identify CD-ROM format.

whenever I try to mount a CD-ROM.  This is something new with 2.5.1
(probably the new bio code), as all prior kernel versions (non-pre)
work fine.  SCSI driver is aic7xxx.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
