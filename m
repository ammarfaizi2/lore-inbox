Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbTFCNPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbTFCNPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:15:49 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:13509 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265004AbTFCNPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:15:48 -0400
Message-Id: <5.1.0.14.2.20030603152622.00aec8d0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 03 Jun 2003 15:29:06 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: arch/i386/math-emu/fpu_trig.c
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: EquXPwZEwehQq3yx1n-NpQWJhde1za0+8G-cLwWfimy4EwoIUe3+4U@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another pedantic issue :-)
In arch/i386/math-emu/fpu_trig.c line 1061 we have :
   else if ( (st0_tag == TAG_Empty) | (st1_tag == TAG_Empty) )

Should be "||" or ?

Margit 

