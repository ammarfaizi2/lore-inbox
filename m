Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264994AbUFWJkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbUFWJkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 05:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUFWJkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 05:40:45 -0400
Received: from cpmx.mail.saic.com ([139.121.17.160]:60645 "EHLO
	cpmx.mail.saic.com") by vger.kernel.org with ESMTP id S264994AbUFWJkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 05:40:39 -0400
Subject: problems with 3com 3c2000 under 2.6.7
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 23 Jun 2004 10:40:21 +0100
Message-Id: <1087983621.19509.8.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm trying to get a gigabit lan set-up for a friend. He's got a mix of
XP and linux machines using 3com 3c2000 adapters attached to a gigabit
switch ( which doesn't understand jumbo frames ).

All MTUs are 1500, but when sending to the linux box he gets ~100 KB/
sec, using ftp, samba, whatever. Pulling from the box delivers ~15 MB/
sec ( which is probably his local disk saturating ). All the boxes are
on the same subnet so there's no router involved, and the performance
stays the same when the cards are conmnected back-to-back so the switch
is eliminated.

I've read about problems with 3c940 adapters, and also had a look at the
3c2000 driver supplied with the card which was forked from the sk98
driver I believe, but it's for 2.4 only.

Has anybody else seen anything like this, or does anybody have any
ideas?

Cheers,
Eamonn

