Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130583AbQJ0Bqo>; Thu, 26 Oct 2000 21:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130434AbQJ0Bqf>; Thu, 26 Oct 2000 21:46:35 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:33805
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S130147AbQJ0BqS>; Thu, 26 Oct 2000 21:46:18 -0400
Date: Thu, 26 Oct 2000 21:56:06 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test9 + LFS
Message-ID: <20001026215606.A19958@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I attempted to create a 4gb sparce file with dd.  It failed.
I created one that was 2.1gb in size which worked.  Then I appeneded more
junk to the end of the file making it over 2.2gb.

doing an ls -l shows:
ls: x: Value too large for defined data type

NOTE: this worked in 2.4.0-test6 and I believe it stopped working around
test8, but I'm not sure.  May have been around test7.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
