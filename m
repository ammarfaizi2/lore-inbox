Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbUB0Jrl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 04:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUB0Jrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 04:47:41 -0500
Received: from viefep12-int.chello.at ([213.46.255.25]:15643 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id S261773AbUB0Jq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 04:46:56 -0500
Message-ID: <403F120C.5090200@freemail.hu>
Date: Fri, 27 Feb 2004 10:46:52 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu; rv:1.6) Gecko/20040115
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.3-mmX locks up reading scratched SVCD
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a scratched SVCD and reading it back with vcdimager-0.7.14
locks up the machine completely. I tried it with kernels is 2.6.3-mm[1234].
I have not tried older kernel.

A flawless SVCD can be read back. I also tried reading back a bad overburned SVCD,
(cdrdao-1.1.8 reported error at the end) and it also locked up the machine.
I fixated this disk, tried reading back -> lockup.
Two IDE CD-RWs produce the same effect: LG 52/24/52 and Sony 48/24/48.
Something must be bad in the ide-cd driver, it should at least report an
error instead of locking up.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.
