Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbUBINJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUBINJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:09:47 -0500
Received: from relaycz.systinet.com ([62.168.12.68]:13765 "HELO
	relaycz.systinet.com") by vger.kernel.org with SMTP id S264457AbUBINJp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:09:45 -0500
Subject: [matroxfb] Second head is on but fb1 not accessible
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: linux-kernel@vger.kernel.org
Cc: vandrove@vc.cvut.cz
Content-Type: text/plain
Message-Id: <1076332180.8115.15.camel@narsil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 09 Feb 2004 14:09:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using matroxfb from (2.6.2 and 2.6.0 patch from
http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/ tested too) on
G400 (32MB dual head). Other details are SMP, preempt kernel, Debian
unstable.

Framebuffer on first head is working fine, the problem is that dmesg
says that second head is on (matroxfb_crtc2: secondary head of fb0 was
registered as fb1) but it's not true. Every tool (matroxset, fbset, ..)
trying to touch fb1 gets:

Cannot open /dev/fb1: No such device

I think my configuration is OK, it's done according to several
framebuffer TV-out howtos.

I can't send actual kernel config file or dmesg at the moment, won't be
at affected computer till weekend.

Does anyone else has the same problem? Any suggestions?

Thanks,

Jan "Pogo" Mynarik

-- 
Jan Mynarik <mynarikj@phoenix.inf.upol.cz>

