Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTDQNDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 09:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTDQNDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 09:03:38 -0400
Received: from [63.246.199.14] ([63.246.199.14]:13696 "EHLO ns.briggsmedia.com")
	by vger.kernel.org with ESMTP id S261329AbTDQNDh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 09:03:37 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Help with virus/hackers
Date: Thu, 17 Apr 2003 10:15:13 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304171015.13474.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please redirect me if this is not the appropriate place for this post.

I have several Debian/Woody/2.4.19 webserver/firewalls at various locations 
that seem to have been hacked or victum of a worm or virus.  It is hard to 
articulate exactly the symptoms since it quickly brings the system down, but 
here is what I know so far:

1) There is no more output to /var/log/syslog.  The contents of the file is 
'0'.
2) 'last' works, but with no unexpected ftp or telnet logins.
3) Windows systems on the inside seem to have been infected with the 
W23.HLLW.ULTIMAX worm that propagates through Windows networking.  Samba was 
indeed running on the servers.
4) If I telnet into the server and 'ls', I get:
ls: uncrecognized prefix: do
ls: unparsable value for LS_COLORS environment variable

But I can su to root.

5) On some systems I rebooted and got the console errors "can't open 
/etc/console/boottime.kmap.gz", and it can't seem to mount the the filesystem 
and complete the boot.

The first machine went down last Friday in San Antonio TX last Friday.  Then 
within a few hours two more went down that was on the same DSL providers's 
network.  Today I experienced the problem on a server in Manchester NH.

Can anyone offer any advice or insight?
-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
