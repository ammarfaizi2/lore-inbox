Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTFDFef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTFDFee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:34:34 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:52331 "EHLO
	mwinf0504.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262878AbTFDFee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:34:34 -0400
Message-ID: <3EDD87FD.6020307@ifrance.com>
Date: Wed, 04 Jun 2003 07:47:41 +0200
From: Yoann <linux-yoann@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: fr, fr-fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: another must-fix: major PS/2 mouse problem
References: <1054431962.22103.744.camel@cube>
In-Reply-To: <1054431962.22103.744.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is there a patch for this bug ?

I have the same problem with my laptop, chip sis630, celeron 1.2Ghz, 256MB of
RAM (32MB for video), mouse on PS/2 (ImPS/2) abd read mp3 throught nfs
partition (ethernet 100MB). I haven't try without traffic on nfs but I will
try next time I boot on the 2.5.70 (currently, I'm running a 2.4.20)

Yoann

Albert Cahalan wrote:
> Lots of people (check Google) get this message
> from the kernel:
> 
> psmouse.c: Lost synchronization, throwing 2 bytes away.
> 
> (the number of bytes will be 1, 2, or 3)
> 
> At work, I get it when there is heavy NFS traffic.
> The mouse goes crazy, jumping around and doing
> random cut-and-paste all over everything. This is
> with a decently fast and modern PC.
> 
> I'll guess that NFS and the mouse both have worker
> threads fighting for CPU time, and neither is RT.


