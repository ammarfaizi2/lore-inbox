Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbTBTQsm>; Thu, 20 Feb 2003 11:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbTBTQsl>; Thu, 20 Feb 2003 11:48:41 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:7614 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266043AbTBTQsj>;
	Thu, 20 Feb 2003 11:48:39 -0500
Importance: Normal
Sensitivity: 
Subject: Re: cifs leaks memory like crazy in 2.5.61
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFEBDD7C2C.B0956D07-ON87256CD3.005C9BC9@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Thu, 20 Feb 2003 10:56:04 -0600
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 02/20/2003 09:57:22
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I run three file API tests regularly against it - fsx, the connecathon
"nfs" tests and iozone and use them as a sort of regression test bucket
(which unfortunately didn't pick this problem up) - as a result of this I
will add "ls -R" of a deep directory tree to the list (ls -R of a shallow
tree doesn't seem to show this problem up) - if there are other useful
filesystem regression cases that I could automate and run, I would love to
know about them.

> request to actually test your stuff, before adding more features!

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com

