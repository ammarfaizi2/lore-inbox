Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263296AbTDVQkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTDVQkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:40:51 -0400
Received: from pointblue.com.pl ([62.89.73.6]:48657 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263296AbTDVQku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:40:50 -0400
Subject: Re: kernel ring buffer accessible by users
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Julien Oster <frodo@dereference.de>
In-Reply-To: <200304221844.05754.fsdeveloper@yahoo.de>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
	 <200304221844.05754.fsdeveloper@yahoo.de>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1051030369.4683.1.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Apr 2003 17:52:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 17:44, Michael Buesch wrote:
> On Tuesday 22 April 2003 18:21, Julien Oster wrote:
> > it's been quite a while that I noticed that any ordinary user, not
> > just root, can type "dmesg" to see the kernel ring buffer.
> 
> just make
> $ chmod 700 /bin/dmesg
and chmod 0600 /var/log/dmesg , as on some systems it is rw-r--r--

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

