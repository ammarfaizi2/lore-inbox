Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271598AbTGQWDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271608AbTGQWDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:03:09 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:49536 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S271598AbTGQWCT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:02:19 -0400
Date: Fri, 18 Jul 2003 00:17:13 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Kernel logs -> console/ 2.6.0t1
Message-ID: <20030717221713.GA3280@finwe.eu.org>
Mail-Followup-To: Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got one more problem with 2.5.75/2.6.0t1 - I cannot 
stop kernel logs from appearing on my console. Usually 
dmesg -n X was good enough[*], but now it doesn't work as 
I expect....

Any ideas?

[*] I've got many different iptables [non 'critical'] logging 
    rules and I'm using klogd

util-linux: 2.11z (as in Debian SID).

config:
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6/config-2.6.0-t1

strace dmesg -n 1:
http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6/2.6.0-test1/strace1

jk

-- 
Jacek Kawa
