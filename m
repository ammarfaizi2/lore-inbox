Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbUJYSCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbUJYSCf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUJYSCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:02:05 -0400
Received: from box.punkt.pl ([217.8.180.66]:53518 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261229AbUJYRyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:54:52 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] linux-libc-headers 2.6.9.1
Date: Mon, 25 Oct 2004 19:53:19 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410251953.19853.mmazur@kernel.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- new 64bit types in linux/types.h are now properly ifdefed, so they don't 
generate errors when using -ansi flag
- in previous release I've missed some defines from linux/compiler.h which 
resulted in some files being broken. Fixed.


Bugfix release, upgrade recommended.
ChangeLog is still missing, but I'll be moving to subversion which should 
resolve this issue.
And my scripts that automatically check new releases for broken headers will 
use -ansi flag from now on, so these types of bugs should not happen anymore.

Enjoy.

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again

