Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbTAaRDj>; Fri, 31 Jan 2003 12:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbTAaRDj>; Fri, 31 Jan 2003 12:03:39 -0500
Received: from vider.out.octet.spb.ru ([194.105.207.66]:38043 "EHLO
	vider.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S261624AbTAaRDR>; Fri, 31 Jan 2003 12:03:17 -0500
Message-ID: <001801c2c94b$f1cc8d80$15cf69c2@nick>
From: "Nick Evgeniev" <nick@octet.spb.ru>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre10-ac2 hangs on OOM
Date: Fri, 31 Jan 2003 20:12:33 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Scanner: exiscan *18eeiP-0002Qr-00*xVy/my4C0Oc* (M.Y.T.H. Inc)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've 2.4.19-pre10-ac2 running threaded applications (java application
server).... And I've got a problem with OOM killer -- it just unable to kill
threaded application (it writes thousands lines to kernel.log, but machine
still not responsive till reboot).

I've tried to play with overcommit setting 2, but w/o much success. It gives
me OOM condition in a few minutes after boot. With overcommit 0 (zero)
server runs just fine for months.

I've seen notes about ingo-oom-killer.patch for 2.5 that should resolve
issues with threaded applications. Do we have it for 2.4 ???


