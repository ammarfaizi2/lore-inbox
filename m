Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTBJSNO>; Mon, 10 Feb 2003 13:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbTBJSNO>; Mon, 10 Feb 2003 13:13:14 -0500
Received: from scrye.com ([216.17.180.1]:17562 "EHLO scrye.com")
	by vger.kernel.org with ESMTP id <S262258AbTBJSNN>;
	Mon, 10 Feb 2003 13:13:13 -0500
Message-ID: <20030210182254.2913.qmail@scrye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Feb 2003 11:22:52 -0700
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x end of tape handling error
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Greetings. 

I have had reported from a client that they are having problems with
backups that span more than one tape. Instead of getting an EOT error
or EOM, they are getting an I/O error wich requires the driver to be
unloaded and reloaded before the tape will work again. 

http://www.linuxtapecert.org/ Says that the redhat 2.4.9-34 kernel is
the last one that had proper EOT handling. Indeed, if they use the
2.4.9-34 kernel, the tape works properly. Thats not a very good
solution however. 

Is this fixed in the latest 2.4.21-pres? How about in 2.5.x?

Has anyone else seen this?

I can get further details to track this down and fix it if it's not
already fixed. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+R+3+3imCezTjY0ERAuZMAKCcQJInxbLBaOOFaTdIRxFhzVT+LQCfSqHg
9HpLrQOVYetev4zhYXnFD/o=
=WN5h
-----END PGP SIGNATURE-----
