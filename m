Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTJCW0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTJCW0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:26:38 -0400
Received: from relay1.eltel.net ([195.209.236.38]:61901 "EHLO relay1.eltel.net")
	by vger.kernel.org with ESMTP id S261351AbTJCW0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:26:37 -0400
Date: Sat, 4 Oct 2003 02:27:28 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: linux-kernel@vger.kernel.org
Subject: A bug (and a fix) in usbserial.c, kernel 2.4.22
Message-Id: <20031004022728.0ff068e1.zap@homelink.ru>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops, sorry, I was a little wrong. Line 1408 shouldn't be removed but
rather moved before the line that sets port->tty to NULL (e.g. line
559).

--
Greetings,
   Andrew
