Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVCNP5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVCNP5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 10:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVCNP5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 10:57:43 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:15762 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261561AbVCNP5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 10:57:11 -0500
Subject: Re: [PATCH][-mm][1/2] cifs: whitespace cleanups for file.c
From: Steve French <smfrench@austin.rr.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0503141626400.2534@dragon.hyggekrogen.localhost>
References: <OF5618ED86.7D1043E7-ON87256FC4.00196859-86256FC4.0019866B@us.ibm.com>
	 <Pine.LNX.4.62.0503141207550.2534@dragon.hyggekrogen.localhost>
	 <1110812782.2294.2.camel@smfhome.smfdom>
	 <Pine.LNX.4.62.0503141626400.2534@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Message-Id: <1110815990.2295.15.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 14 Mar 2005 09:59:50 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 09:36, Jesper Juhl wrote:

> Would it be useful if I split the second patch into a few parts for you? I 
> could split some of the (non cifs_open related) whitespace changes into 
> one, the kfree related changes into another and then a third with the 
> cifs_open rework. Would that make things easier for you?
> 

For the second patch (the one I did not apply) slightly smaller would
make things easier.  For patches that have non-trivial changes - my
preference is to split the patches into the 50-200 line range since they
can be reviewed and put in incrementally.

> I may be able to install windows in vmware or borrow a machine
WindowsXP, Linux/Samba3, LinuxSamba4, Windows2000, Windows2003, etc.
have been very easy to get a hold of and test.  

I have been having a very hard time getting a usable WindowsNT
(and Windows9x) server for testing (I do have one of each at work I can test
against but at home it makes it tough to test).   With the latest vmware, my 
last shot at NT4 install failed (not sure why yet - perhaps NT4 does
not like vmware emulated SCSI and wants IDE only) - at work we have NT4 
in the older vmware working fine but I want to test it on NT4 and Win9x/WinME more,
since they get run the least and are much worse servers than Windows200x, XP and Samba
so test feedback on those on current kernel would be useful.l

Also there are other CIFS server out there - at Connectathon a few weeks ago 
the testing was very helpful.  Compensating for the minor differences among the
server like NetApp, BlueArc, AIX FastConnect etc. is important - and I don't have 
those servers easily accessible to test against.   I am especially interested 
in test feedback with current kernel/cifs against those with other
servers (not just the usual Samba3, Samba4, current Windows).

