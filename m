Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSKBQEl>; Sat, 2 Nov 2002 11:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261287AbSKBQEl>; Sat, 2 Nov 2002 11:04:41 -0500
Received: from main.gmane.org ([80.91.224.249]:58818 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261286AbSKBQEk>;
	Sat, 2 Nov 2002 11:04:40 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: [ANNOUNCE] [PATCH] Linux-2.5.45-mcp2
Date: Sat, 02 Nov 2002 11:12:11 -0500
Message-ID: <aq0tca$5h4$1@main.gmane.org>
References: <200211020255.05597.m.c.p@wolk-project.de>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1036253387 5668 130.127.121.177 (2 Nov 2002 16:09:47 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Sat, 2 Nov 2002 16:09:47 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:

> Hi there,
> 
> point me to/send me the fixes/patches you want to see in here please!
> 

Here's a few:

*WOLK's TIOCGDEV patch [you have it]

*High-res timers: 
[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=103606199703196&w=4
[2] http://marc.theaimsgroup.com/?l=linux-kernel&m=103606200203215&w=4
[3] http://marc.theaimsgroup.com/?l=linux-kernel&m=103609269506881&w=4
[4] http://marc.theaimsgroup.com/?l=linux-kernel&m=103608788300481&w=4

*[NFS] kNFSd - 1 of 2 - Use ->sendpage to send nfsd (and lockd) replies:
[1] http://marc.theaimsgroup.com/?l=linux-nfs&m=103612463504116&w=4

*[NFS] kNFSd - 2 of 2 - Support zero-copy read for NFSD:
[1] http://marc.theaimsgroup.com/?l=linux-nfs&m=103612462404104&w=4

*[NFS] Secure user authentication using RPCSEC_GSS:
[1] http://marc.theaimsgroup.com/?l=linux-nfs&m=103609628111315&w=4
[2] http://marc.theaimsgroup.com/?l=linux-nfs&m=103609605611023&w=4
[3] http://marc.theaimsgroup.com/?l=linux-nfs&m=103609597410932&w=4
[4] http://marc.theaimsgroup.com/?l=linux-nfs&m=103609597610936&w=4
[5] http://marc.theaimsgroup.com/?l=linux-nfs&m=103609666811720&w=4
[6] http://marc.theaimsgroup.com/?l=linux-nfs&m=103609627211299&w=4
[7] http://marc.theaimsgroup.com/?l=linux-nfs&m=103609682311889&w=4

*[NFS] Kerberos 5 security framework for RPCSEC_GSS:
[1] http://marc.theaimsgroup.com/?l=linux-nfs&m=103609919914755&w=4

*Get latest diff for XFS+DMAPI+ACL+KDB against cvs:
[1]cvs -z9 -d:pserver:cvs@oss.sgi.com:/cvs login
[2]password is "cvs"
[3]cvs -z9 -d:pserver:cvs@oss.sgi.com:/cvs export -rHEAD linux-2.5-xfs/linux
[4]diff linux-2.5-xfs/linux to a virgin 2.5.45 tree

*Import dcl bitkeeper tree [contains LKCD and LTT!] from:
[1] bk://bk.osdl.org/dcl-2.5

*Import ppc tree [contains radeonfb fixes] from:
[1] bk://ppc.bkbits.net/linuxppc-2.5

Cheers,
Nicholas


