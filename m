Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVEPR4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVEPR4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVEPR4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:56:00 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:56755 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261533AbVEPRzz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:55:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iF6Huypup2OkK7VqBqMHaT7M+FDrb9fYB5ab3yPMdyAcfdPHwgO0l5oEmzNveGF9TEqpHFI2f7VXP0Dg7OLHMP9gnLQhB8d3ZHzjMafxbx1SinKf56IJeHhZxEgAm9U9/sAkvcZBM2ym8eF0AlJ37cLzNA8X0uRLwJ5W/hNYBlY=
Message-ID: <e8be733905051610556a199637@mail.gmail.com>
Date: Mon, 16 May 2005 19:55:53 +0200
From: Andreas Pokorny <andreas.pokorny@gmail.com>
Reply-To: Andreas Pokorny <andreas.pokorny@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ioctl entries for joystick in compat_ioctl.h
Cc: jakub@redhat.com, ecd@skynet.be, pavel@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there, 

What happened to the patch discribed in: 
http://www.ussg.iu.edu/hypermail/linux/kernel/0412.1/0185.html

The patch only worked particularly, there are still some ioctl errors
when running 32bit games like vendetta on x86_64:

ioctl32(vendetta:29822): Unknown cmd fd(6) cmd(80806a13){00}
arg(08301694) on /dev/input/js0

But the game is fully playable. I would really like to see that patch
in the vanilla kernel.

Regards
Andreas Pokorny
