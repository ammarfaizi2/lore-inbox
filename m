Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbTBEQmK>; Wed, 5 Feb 2003 11:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTBEQmK>; Wed, 5 Feb 2003 11:42:10 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:9185 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S261721AbTBEQmJ>;
	Wed, 5 Feb 2003 11:42:09 -0500
Message-Id: <200302051659.LAA05950@moss-shockers.ncsc.mil>
Date: Wed, 5 Feb 2003 11:59:15 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
To: hahn@physics.mcmaster.ca
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: DK/FwnvV0j7gl+JQQx2UkQ==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Hahn wrote:
> can all this LSM nonsese be CONFIG'ed out of the kernel as promised?

Yes.  CONFIG_SECURITY=n makes it all go away.  But if your mind isn't
completely closed on the topic, you might want to read some of the
following published papers before concluding that it is nonsense:

1) The Inevitability of Failure:  The Flawed Assumption of Security in
Modern Computing Environments, available online from
http://www.nsa.gov/selinux/inevit-abs.html.

2) The published papers about SELinux from the 2001 FREENIX and 2001
OLS, available online from http://www.nsa.gov/selinux/docs.html.

3) The published papers about LSM from the 2002 Usenix Security and
2002 OLS, available online from http://lsm.immunix.org/lsm_doc.html.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

