Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130107AbQLJLlW>; Sun, 10 Dec 2000 06:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130549AbQLJLlM>; Sun, 10 Dec 2000 06:41:12 -0500
Received: from c334580-a.snvl1.sfba.home.com ([65.5.27.33]:17169 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S130107AbQLJLlF>; Sun, 10 Dec 2000 06:41:05 -0500
Date: Sun, 10 Dec 2000 03:11:14 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: No shared memory??
Message-ID: <Pine.LNX.4.30.0012100306530.4353-100000@playtoy.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, got a tiny little bug here.

When running top, procinfo, or free I get 0 for Shared memory. Obviously
this is incorrect. What has changed from the 2.2.x and the 2.4.x that
would cause these apps to misreport this information.

This IS information gained through the /proc filesystem which is kernel
based is it not? This would seem to make it a kernel issue since the
change in format is brought about by how the kernel reports this
information if i understand this correctly.

(If I am wrong, please let me know. I hate laboring under false
assumptions)


How do I fix this problem in any event?


David PGPKeys Downey


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
