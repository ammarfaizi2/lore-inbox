Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270371AbTGNLio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270377AbTGNLio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:38:44 -0400
Received: from mail2.zrz.TU-Berlin.DE ([130.149.4.14]:52117 "EHLO
	mail2.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id S270371AbTGNLim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:38:42 -0400
X-Mailer: exmh 2.3 [17-Jan-2001] with nmh-1.0.4
Comment: Software is like sex - it's better when it's free. --Linus Torvalds
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-2.6.0-test1] make xconfig fails 
In-reply-to: Your message of "Mon, 14 Jul 2003 13:48:35 +0200"
             <Pine.LNX.4.44.0307141325170.717-100000@serv> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Jul 2003 13:53:29 +0200
From: Frank Elsner <Elsner@zrz.TU-Berlin.DE>
Message-Id: <E19c1tZ-00070Q-JU@bronto.zrz.TU-Berlin.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 13:48:35 +0200 Roman Zippel wrote:
> On Mon, 14 Jul 2003, Frank Elsner wrote:
> > RHL 7.3, gcc-2.95.3, copied .config from 2.4.21 source tree 
> >                                       to linux-2.6.0-test1 source tree.
> > make oldconfig went ok.
> > 
> > Later make xconfig failed:
> 
> It's most likely a mismatch between QT and g++.
> Older RedHat systems have that problem, although most of the time it 
> already fails at linking.
> 
> > /usr/lib/qt3-gcc2.96/bin/moc -i scripts/kconfig/qconf.h -o scripts/kconfig/qconf
> 
> Which version is the g++ compiler?
# g++ -v
Reading specs from /usr/local/gcc-2.95.3/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/specs
gcc version 2.95.3 20010315 (release)


--Frank Elsner


