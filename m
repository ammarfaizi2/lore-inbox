Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTETBai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTETBai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:30:38 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:29344 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263206AbTETBah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:30:37 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>
	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
	<babhik$sbd$1@cesium.transmeta.com>
	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com>
	<m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com>
	<1053392095.21582.48.camel@imladris.demon.co.uk>
	<3EC9803F.6010701@zytor.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 20 May 2003 10:42:56 +0900
In-Reply-To: <3EC9803F.6010701@zytor.com>
Message-ID: <buoy91275r3.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:
> Types use the __kernel_* namespace *only*; structures use struct __kernel_*.

What, do you mean _every_ kernel internal type would use such names?
That's completely horrid...

-Miles
-- 
Come now, if we were really planning to harm you, would we be waiting here, 
 beside the path, in the very darkest part of the forest?
