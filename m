Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271997AbRIDQph>; Tue, 4 Sep 2001 12:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272008AbRIDQpZ>; Tue, 4 Sep 2001 12:45:25 -0400
Received: from ra.abo.fi ([130.232.213.1]:51700 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S272002AbRIDQot>;
	Tue, 4 Sep 2001 12:44:49 -0400
From: Mikko Huhtala <mhuhtala@abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15253.1002.189305.674221@barley.abo.fi>
Date: Tue, 4 Sep 2001 19:40:10 +0300
To: linux-kernel@vger.kernel.org
Subject: NFS to Irix server broken again in 2.4.9
X-Mailer: VM 6.93 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't know if this is well-known already. The 2.4.9 kernel NFS client
does not see all files/directories mounted from an Irix 6.5 NFS server
(the 32/64-bit cookie problem). Changing NFS versions from 3 to 2 does
not help. 2.4.8 client works for me, but the problem is apparently
back in 2.4.9. I am running 2.4.9 with MOSIX 1.3.0 patches, but I do
not think that those are the cause of the problem.


Mikko Huhtala
