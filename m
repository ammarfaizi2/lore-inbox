Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTDVQm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTDVQm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:42:28 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:27038 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263298AbTDVQm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:42:27 -0400
Date: Tue, 22 Apr 2003 18:54:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: Julien Oster <frodo@dereference.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
Message-ID: <20030422165418.GA7178@wohnheim.fh-wedel.de>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org> <200304221844.05754.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304221844.05754.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 April 2003 18:44:05 +0200, Michael Buesch wrote:
> 
> On Tuesday 22 April 2003 18:21, Julien Oster wrote:
> > it's been quite a while that I noticed that any ordinary user, not
> > just root, can type "dmesg" to see the kernel ring buffer.
> 
> just make
> $ chmod 700 /bin/dmesg

scp /bin/dmesg remote:
ssh remote ./dmesg

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
