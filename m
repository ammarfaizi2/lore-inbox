Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131876AbQLLPPB>; Tue, 12 Dec 2000 10:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131890AbQLLPOu>; Tue, 12 Dec 2000 10:14:50 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:4 "HELO gherkin.sa.wlk.com")
	by vger.kernel.org with SMTP id <S131876AbQLLPOc>;
	Tue, 12 Dec 2000 10:14:32 -0500
Message-Id: <m145qey-0005keC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: followup: 2.4.0-test12 unresolved SCSI symbols
To: linux-kernel@vger.kernel.org
Date: Tue, 12 Dec 2000 08:44:04 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The quick (not necessarily correct) fix is to back out that
portion of the linux/drivers/scsi/Makefile patch that moves
"scsi_syms.o" from line 33 to line 126.

"It works for me." (tm)

-- 
Bob Tracy                                            rct@frus.com
-----------------------------------------------------------------
 "We might not be in hell, but we can see the gates from here."
 --Phoenix resident, Summer of 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
