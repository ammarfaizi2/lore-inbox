Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129960AbQLLNy4>; Tue, 12 Dec 2000 08:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130836AbQLLNyq>; Tue, 12 Dec 2000 08:54:46 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:4 "HELO gherkin.sa.wlk.com")
	by vger.kernel.org with SMTP id <S129960AbQLLNyb>;
	Tue, 12 Dec 2000 08:54:31 -0500
Message-Id: <m145pPT-0005keC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: 2.4.0-test12 unresolved SCSI symbols
To: linux-kernel@vger.kernel.org
Date: Tue, 12 Dec 2000 07:23:59 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone else mentioned the problem in a different context, so
this report isn't exactly new...  LOTS of unresolved symbols in
several SCSI modules.  Here's the list for "st.o":

scsi_unregister_module
scsi_block_when_processing_errors
scsi_release_request
scsi_do_req
scsi_allocate_request
print_req_sense
scsi_register_module
scsi_ioctl

Other modules I'm personally having problems with are "sg.o" and
"sr_mod.o".  I'll have a look and see if there's a quick fix if
someone doesn't beat me to the punch.

-- 
Bob Tracy                                            rct@frus.com
-----------------------------------------------------------------
 "We might not be in hell, but we can see the gates from here."
 --Phoenix resident, Summer of 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
