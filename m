Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWFIUZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWFIUZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWFIUZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:25:58 -0400
Received: from mail2.lanck.net ([62.152.87.202]:49163 "EHLO mail.protei.ru")
	by vger.kernel.org with ESMTP id S1751385AbWFIUZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:25:57 -0400
Message-ID: <4489D93F.7090401@protei.ru>
Date: Sat, 10 Jun 2006 00:25:35 +0400
From: Nickolay <nickolay@protei.ru>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: initramfs: who does cat init.sh >> init ?
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys, in recent kernels, when building kernel with initramfs with V=1, 
i  see interesting one:

cat /usr/kernel/BE/2_6/initramfs/init.sh >/usr/kernel/BE/2_6/initramfs/init

But i can't find, who really do that. Can anyone point me?
I need to fix that, because it's impossible for me to have two copy of init.

Thanks.

-- 
Nickolay Vinogradov

