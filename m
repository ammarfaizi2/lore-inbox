Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUKWOI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUKWOI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUKWOGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:06:06 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17024 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261259AbUKWOFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:05:32 -0500
Date: Tue, 23 Nov 2004 15:05:21 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: Bill Davidsen <davidsen@tmr.com>, Jakub Jelinek <jakub@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
In-Reply-To: <je8y8t8n5t.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.53.0411231504560.28979@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
 <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
 <20041122113328.GQ10340@devserv.devel.redhat.com> <41A25D53.9050909@tmr.com>
 <je8y8t8n5t.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why can't you do dest=src? Assignment of struct to struct has been a part
>> of C since earliest times.
>
>It's not a struct, it's an array (of one element of struct type).  You
>can't assign arrays.

int callme(const char *fmt, struct { ... } argp[1]) {
	dest = *argp;
}

Maybe that way?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
