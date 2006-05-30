Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWE3NY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWE3NY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 09:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWE3NY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 09:24:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:1947 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751495AbWE3NYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 09:24:55 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc4-mm3 cfq oops->panic w. fs damage
From: Mike Galbraith <efault@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060530123652.GV4199@suse.de>
References: <1148793123.7572.22.camel@homer>
	 <20060528052514.GQ27946@ftp.linux.org.uk> <1148796018.11873.11.camel@homer>
	 <1148802491.8083.7.camel@homer> <1148803384.8757.7.camel@homer>
	 <1148804675.7755.2.camel@homer> <1148900440.9817.46.camel@homer>
	 <20060530123652.GV4199@suse.de>
Content-Type: text/plain
Date: Tue, 30 May 2006 15:27:12 +0200
Message-Id: <1148995632.7574.4.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 14:36 +0200, Jens Axboe wrote:

> I'm suspecting a recent -mm change, since git-cfq hasn't changed in
> quite a while and it used to work just fine.

It's apparently not mm.  I just plugged it into 2.6.17-rc4, and get the
same explosion.  It doesn't seem to play well with the changes in
2.6.17-rc1.

	-Mike

