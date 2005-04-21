Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVDUSbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVDUSbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVDUSbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:31:47 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:41070 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261611AbVDUSbf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:31:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EqHq57vc75hBtkcj4x5ydjCBcpHHdfPtn8W6q/m1Q9F3ZZWb70U7CdToB3fptfPq8zRT7tSc1iXXszMBB7Owg0qrkEySWWdKksEscoL5km6n7K52GnDzGzCLXs6jbX+3Lf7G5dmxt/Zxqa6RGoF9dasmrr68dOtpubVP1TkuR+k=
Message-ID: <7f45d93905042111313ae10b39@mail.gmail.com>
Date: Thu, 21 Apr 2005 11:31:32 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Hang when using a Matrox G550 with DVI
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I have a DVI display plugged into my Matrox G550 video card the
Linux kernel 2.6.11 hangs while booting. This can be worked around by
"disabling CONFIG_VIDEO_SELECT and/or comment out call to store_edid
in arch/i386/boot/video.S" [1], or by unplugging the DVI display
before the kernel boots and plugging it back in before X starts. This
is the same bug listed here [2], and it has been around since the
2.5.67-bk6 days.

Please cc me in your reply. Cheers,
Shaun

[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0408.2/0434.html
[2] http://bugme.osdl.org/show_bug.cgi?id=1458
