Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757072AbWKVWVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072AbWKVWVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 17:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757077AbWKVWVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 17:21:30 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:50882 "EHLO
	aa012msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1757072AbWKVWV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 17:21:29 -0500
Date: Wed, 22 Nov 2006 23:21:24 +0100
From: The Peach <smartart@tiscali.it>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
Message-ID: <20061122232124.09695d57@localhost>
In-Reply-To: <87zmaj1cpv.fsf@duaron.myhome.or.jp>
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<20061122163001.0d291978@localhost>
	<8764d7v4nh.fsf@duaron.myhome.or.jp>
	<20061122201008.17072c89@localhost>
	<87r6vvs2k4.fsf@duaron.myhome.or.jp>
	<20061122203859.017d5723@localhost>
	<87zmaj1cpv.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
X-Face: aWQ;)]T=TRHr<lws7%!n"V4D8C=^2]U'G>ZwK=Tde.eaxLu/iMa)ro#a*o5[K!4mKaP^74m
 !c#;yi;6a?i`K,R<{Y"),;f@t9e\p]Pl$$h@o%>zDsLL;/x|t{bKr;L'":ocL?&7X&q7%6<OTn}fw;
 PQ$>d"axD!#!12}&]OFn'YfVxe(>EyQDK?wne){aEu[,_o~30L}Anqdk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 04:51:56 +0900
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> The both of patch and option should be needed. Because the following
> filename is not shortname, shortname option doesn't affect.
> 
> If you test shortname=winnt without patch, it should still show the
> problem of following filename, but it should be rare case though.
> 
> Can you test it?

unfortunately not, the files have been renamed and renaming them back I can't reproduce the magical effect they did before.
Now I will try to rescan for any kind of files with long names and see if with the option on and without the patch it will re-generate that kind of errors they gave me.
I must thank you a lot, maybe a bottle of wine will do it ;)
anyway I didn't get why some files will copy with the right case and other don't. Was it a problem with the dentry table randomly failing in saving the filename? the shortname option in the Docs isn't well accurate in explaining the meaning of "Windows X rule for display/create", I will investigate after having checked the 32 GB of files. thanks again.

-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it
