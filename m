Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTJYVgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTJYVgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:36:20 -0400
Received: from main.gmane.org ([80.91.224.249]:12442 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263007AbTJYVgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:36:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.0-testX and pppd/pppoe stuck after connecting
Date: Sat, 25 Oct 2003 23:36:15 +0200
Message-ID: <yw1xy8v9gfu8.fsf@kth.se>
References: <2523214.1067115416222.JavaMail.jpl@remotejava>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Jan Ploski <jpljpl@gmx.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ffRKzP966dPFpcfHNsN3wR2eHyk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Ploski <jpljpl@gmx.de> writes:

> Ever since I upgraded from 2.4.18 to 2.6.0-test? (now -test8),
> I have been encountering problems with my pppd/pppoe setup.
> Specifically, right after the ppp0 interface is brought up, and several
> packets go through that interface (4-5 packets RX/TX), no more packets
> are transmitted until I restart pppd and reconnect to my ISP.
> ping www.google.com will report 100% packet loss, and I cannot see the
> TX packet count on ppp0 increasing. Nothing suspicious appears in ppp.log.
> More often than not, I have to reconnect multiple times until at last
> a working connection is established.
>
> I may have not included all required information, but I don't know what
> might be useful in diagnosing this problem (this knowledge would possibly
> let me correct it without posting). I believe it is kernel-related because
> with 2.4.x everything works fine in the same circumstances. The software
> versions are: pppd version 2.4.1, pppoe version 3.3 (from roaringpenguin.com)

FWIW, I'm sending this mail using pppd 2.4.1 and Roaring Penguin pppoe
3.5 on Linux 2.6.0-test8.  Occasionally, maybe one out of 10 times or
less, the connect times out, but I've attributed that to my ISP.

-- 
Måns Rullgård
mru@kth.se

