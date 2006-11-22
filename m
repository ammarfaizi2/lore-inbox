Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752249AbWKVTjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbWKVTjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbWKVTjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:39:06 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:5056 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1752249AbWKVTjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:39:03 -0500
Date: Wed, 22 Nov 2006 20:38:59 +0100
From: The Peach <smartart@tiscali.it>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
Message-ID: <20061122203859.017d5723@localhost>
In-Reply-To: <87r6vvs2k4.fsf@duaron.myhome.or.jp>
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<20061122163001.0d291978@localhost>
	<8764d7v4nh.fsf@duaron.myhome.or.jp>
	<20061122201008.17072c89@localhost>
	<87r6vvs2k4.fsf@duaron.myhome.or.jp>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; i686-pc-linux-gnu)
X-Face: aWQ;)]T=TRHr<lws7%!n"V4D8C=^2]U'G>ZwK=Tde.eaxLu/iMa)ro#a*o5[K!4mKaP^74m
 !c#;yi;6a?i`K,R<{Y"),;f@t9e\p]Pl$$h@o%>zDsLL;/x|t{bKr;L'":ocL?&7X&q7%6<OTn}fw;
 PQ$>d"axD!#!12}&]OFn'YfVxe(>EyQDK?wne){aEu[,_o~30L}Anqdk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 04:29:15 +0900
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> This is different thing. Please try "shortname=winnt" or "shortname=mixed"
> mount option for shortname (default is shortname=lower).

finally it works (mounted with shortname=winnt).
Did this patch really solve the issue or was just a "shortname" option problem? I didn't even know that option would made the difference.
now I just should get rid of verbose output.

-- 
Matteo 'Peach' Pescarin

ICQ UIN = 71110111
Jabber ID = smartart@unstable.nl
Web Site = http://www.smartart.it
GeCHI = http://www.gechi.it
