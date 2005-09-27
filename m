Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVI0NAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVI0NAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVI0NAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:00:01 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:55203 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S964862AbVI0NAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:00:00 -0400
Message-ID: <433941E0.7010005@cs.aau.dk>
Date: Tue, 27 Sep 2005 14:58:08 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Framework for automatic Configuration of a Kernel
References: <20050927125300.24574.qmail@web51014.mail.yahoo.com>
In-Reply-To: <20050927125300.24574.qmail@web51014.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

Ahmad Reza Cheraghi wrote:
> 
> Again another good Idea. Your right;-) Its better. 
> But it better getting another way of detecting the
> Hardware/Software etc. from the System without using
> lspci or the proc-files...?

Well, the proc files are always here (it removes one requisite which is
to have lspci installed). So, I would go for the proc files.

> Something that gets all
> the Hardware Information directly from the I/O and not
> from the Kernel. The good thing about lspci is that it
> does both . But it doesnt say if there is  a CDROM or
> floppy-disc... 

Well, lspci is for PCI bus devices, it's already a lot, but not
everything (that's why you need several scripts/methods to detect
hardware, I guess).

> I tryed alot to search for something
> like that but without any success. I heard about this
> Otopia Project. I google after it but I didnt find
> anything usefule. I think its dead. 

I don't know this project.

Regards
-- 
Emmanuel Fleury

echo '16i[q]sa[ln0=aln100%Pln100/snlbx]sb20293A2058554E494Csnlbxq'|dc
  -- Unknown
