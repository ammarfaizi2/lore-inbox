Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWE0MmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWE0MmN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWE0MmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:42:13 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:29839 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751026AbWE0MmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:42:12 -0400
Date: Sat, 27 May 2006 14:42:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Garzik <jeff@garzik.org>
cc: Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
In-Reply-To: <447838EB.9060900@garzik.org>
Message-ID: <Pine.LNX.4.61.0605271441080.4857@yvahk01.tjqt.qr>
References: <4477B905.9090806@garzik.org> <Pine.LNX.4.61.0605271212210.6670@yvahk01.tjqt.qr>
 <447838EB.9060900@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Pretty long script. How about this two-liner? It does not show 'bytes
>> chomped' but it also trims trailing whitespace.
>> 
>> #!/usr/bin/perl -i -p
>> s/[ \t\r\n]+$//
>
> Yes, it does, but a bit too aggressive for what we need :)
>
Whoops, should have been s/[ \t\r]+$//
And the CL form is
  perl -i -pe '...'

Somehow, you can't group it to -ipe, but who cares.


Jan Engelhardt
-- 
