Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUD0Otb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUD0Otb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264160AbUD0Otb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:49:31 -0400
Received: from web41203.mail.yahoo.com ([66.218.93.36]:39096 "HELO
	web41203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264154AbUD0Ot3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:49:29 -0400
Message-ID: <20040427144922.43436.qmail@web41203.mail.yahoo.com>
Date: Tue, 27 Apr 2004 07:49:22 -0700 (PDT)
From: Pierre Berthier <berthierp@yahoo.com>
Subject: Re: PROBLEM: memory managment bug in kernel >= 2.4.23
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> every two minutes a "__alloc_pages: 0-order allocation failed 
> (gfp=0x21/0)"
> message.

I have discovered that this bug is triggered by doing a 'cat
/proc/scsi/gdth/1'.  I have posted a bug report to linux-scsi.

Pierre
