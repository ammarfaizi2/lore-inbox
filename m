Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbTJUPNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbTJUPM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:12:56 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:15111 "EHLO
	imgserv04.imerge-bh.co.uk") by vger.kernel.org with ESMTP
	id S263157AbTJUPKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:10:42 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB016038F6@imgserv04>
From: James Finnie <jf1@IMERGE.co.uk>
To: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: VIA IDE performance under 2.6.0-test7/8?
Date: Tue, 21 Oct 2003 16:11:00 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does 'hdparm -a 512 /dev/hd?' help?
> --bartlomiej

Indeed it does, and -a 1024 is even better, but why the change?  Under
2.4.21, I only have a readahead value of 8 set, in fact hdparm barfs if you
try to set anything above 255!

Any ideas?

James.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


