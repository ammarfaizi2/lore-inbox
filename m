Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbRAVPrR>; Mon, 22 Jan 2001 10:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132402AbRAVPrP>; Mon, 22 Jan 2001 10:47:15 -0500
Received: from ftp.apple.asimov.net ([209.249.142.209]:42514 "HELO
	isaac.asimov.net") by vger.kernel.org with SMTP id <S132038AbRAVPrE>;
	Mon, 22 Jan 2001 10:47:04 -0500
Date: Mon, 22 Jan 2001 07:47:03 -0800
From: Patrick Michael Kane <modus-linux-kernel@pr.es.to>
To: linux-kernel@vger.kernel.org
Subject: Hard freeze on 2.4.1pre9 during fsck
Message-ID: <20010122074703.A9919@pr.es.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Mailer: Mutt http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am experiencing hard lockups (no oops, no response to ALT-SYSREQ) on a
dual pentium pro running 2.4.1pre9.  The system has two Promise IDE
controllers installed (PDC20246 and PDC 20262) with a drive hanging off of
each channel.  In addition, the onboard PIIX4 has a single drive hanging off
the first channel.

The hard lockup occurs during heavy IO during a boot-up fsck.  The system is
fscking three of the four Promise channels and the PIIX4 channel
simultaneously.  The system locks up hard after 60-90 seconds of fscking.

Since the system does not respond to ALT-SYSREQ, I have been unable to get
any dumps.  Does anyone have any thoughts on how to proceed?

Best,
-- 
Patrick Michael Kane
<modus@pr.es.to>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
