Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWF0Xla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWF0Xla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWF0Xla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:41:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:13920 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422729AbWF0Xl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:41:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hnhvd2jbi5ePNNNRy86sohMmZHWa+v+JhOMBl/Lm2jkWPu6/WLue4WYgJe1X+UoD6CI7NBvhizlLWZWZGYxjlrTQfEdkE7vEFpYiUmNZ6lj2DaTLMs22+8cnuhasZOguL+cxuMSN53xSxzFyqcQd4SuQKxCPS2xCMPZRhpINIUQ=
Message-ID: <9bb377710606271641k480ec30s8aaf3c1b445fdf19@mail.gmail.com>
Date: Tue, 27 Jun 2006 19:41:29 -0400
From: "Brandon Berhent" <cheater1034@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm3 possible reiser4 bug
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I've upgraded to 2.6.17-mm3 today, and there is a problem that happens
when kexec is initiliazed

Reiser4[pdflush(170)] commit_current_atom (fs/reiser4/txnmgr.c:1062)[zam-597]

I receive the following every time kexec initializes, then the kernel
panics and crashes. I rebooted to a rescue and ran fsck.reiser4 and it
found a couple of small errors and fixed them. Then I tried it again,
and I got the same thing on kexec initiliazation, except this time the
FS wouldnt boot anymore, and i ran fsck.reiser4 and it came up with a
severe error requiring me to run fsck.reiser4 --build-fs.

A couple other people have also tried it and had the same problem.
2.6.17-mm1 and 2.6.17-mm2 do not have any problems for me.

Any help his appreciated
Thanks
-Brandon
