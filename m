Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966567AbWKTTma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966567AbWKTTma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966569AbWKTTma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:42:30 -0500
Received: from vsmtp3alice.tin.it ([212.216.176.143]:39828 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S966567AbWKTTm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:42:29 -0500
Date: Mon, 20 Nov 2006 18:49:12 +0100
From: The Peach <smartart@tiscali.it>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
Message-ID: <20061120184912.5e1b1cac@localhost>
In-Reply-To: <877ixqhvlw.fsf@duaron.myhome.or.jp>
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
X-Face: aWQ;)]T=TRHr<lws7%!n"V4D8C=^2]U'G>ZwK=Tde.eaxLu/iMa)ro#a*o5[K!4mKaP^74m
 !c#;yi;6a?i`K,R<{Y"),;f@t9e\p]Pl$$h@o%>zDsLL;/x|t{bKr;L'":ocL?&7X&q7%6<OTn}fw;
 PQ$>d"axD!#!12}&]OFn'YfVxe(>EyQDK?wne){aEu[,_o~30L}Anqdk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 02:32:43 +0900
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> I couldn't reproduce this for now. Could you tell mount options which
> you used? and after mount, "cat /proc/mounts", please.

# mount | grep vfat 
/dev/sdb1 on /mnt/iomega type vfat (rw,uid=1000,gid=100,codepage=850,iocharset=iso8859-15) 

it seems only related to those kind of files, but I don't know how to inspect the "file properties" and why these files behave like this.
As you can see and with a strace made on cp, the files _seems_ to be copied with the correct case, whilst it isn't, as seen with "ls". This and other things let me think is a vfat problem.

-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it
