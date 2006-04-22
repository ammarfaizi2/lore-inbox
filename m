Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWDVSbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWDVSbE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWDVSbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:31:03 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:26795 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750871AbWDVSbB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:31:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eT7YQUP7PR1cMLcNqmyif4lJZIa9Xjt0QDVdZ+Zdn8D3jX/+BijYx/ZLHM5BFKJaClxDjXd0FQmPwCAYft1GPbGFU64sjHRCEY3CevhbDEEVW8YRCpoSFnGRLYk84CuUAqhtQn7yWgOA4Tzxbc7N33ARS5lo9IV7VJSCnuu1Auk=
Message-ID: <34af3d780604220024u1aba2fc8y54337b75cfadedae@mail.gmail.com>
Date: Sat, 22 Apr 2006 09:24:46 +0200
From: "Domen Stangar" <domen.stangar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: IPC SHM changed; shmat does not return same shared memory address for all processes (virtual) after 2.6.8 ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

can anyone please explain me why there is a change in shmat so that
each process gets different address(looks like virtual) to shared
memory ?
(even though i give parameter shmaddr)

E.g. 8 processes sharing same XImage including xserver on local machine.
If i get different address on each process then xserver fails to
access the image.
This worked fine to kernel version 2.6.8.

Is there any solution to this ?
Will it stay like this in future ?

Thanks,
Domen
