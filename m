Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWJNDg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWJNDg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 23:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbWJNDg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 23:36:27 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:50352 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1752042AbWJNDg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 23:36:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=h3C03udVQAF/BQLAsjImSoyv6jU/d3Yl1b3r0Orhs7JimjlzFmNEzlySc+o1pCgBAYYZs0vNuhGKKJsbj08vHJx6elLiYOHK6FjGXCnegRWQidiblvgONx0BGDfHzZUUhinrDHU/NNTapCWXpUYlRjuYKbxkNCbYdrQC7kPQTmY=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: bzip2 tarball 2.6.19-rc2 packaged wrong?
Date: Fri, 13 Oct 2006 23:36:20 -0400
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200610132336.21392.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, something in git  broke the prepackaged tarball/bzip2 generation?

$ tar -jxvf linux-2.6.19-rc2.tar.bz2
linux-2.6.19-rc2.gitignore
linux-2.6.19-rc2COPYING
linux-2.6.19-rc2CREDITS
linux-2.6.19-rc2Documentation/
linux-2.6.19-rc2Documentation/00-INDEX
linux-2.6.19-rc2Documentation/ABI/
linux-2.6.19-rc2Documentation/ABI/README

-rc1 was ok.

Anyone else notice this?

Thanks, 
Shawn.
