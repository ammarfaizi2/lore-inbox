Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWIGS36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWIGS36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWIGS36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:29:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:1227 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161072AbWIGSIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:08:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JAKdd4KTBi4he2XxsxBFHVfxCHZXsF3KUCLQfQjQ4GeRN3EUTpJxBkoze/oKKe1ZUzFprID8BRlQHw+ZS67+u/NfHwJog3kXJXzA2WhLrtFfVo+9ncMI56RpuFQQIkOXh7r3gJn2Ho77rrRE0noG2Qe/ct2SXzStb0iSM6BNc4Y=
Message-ID: <1b270aae0609071108h22bc10b0v5d2227abfc66c53c@mail.gmail.com>
Date: Thu, 7 Sep 2006 20:08:53 +0200
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: top displaying 50% si time and 50% idle on idle machine
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel 2.6.17.11 with tg3 network driver, NAPI enabled (Distro CentOS 4.4).
top shows strangely 50% idle even if the machine is _completely_ idle.

top - 01:04:30 up 4 days, 12:05,  2 users,  load average: 0.00, 0.00, 0.00
Tasks:  34 total,   2 running,  32 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 50.0% id,  0.0% wa,  0.0% hi, 50.0% si
Mem:   3634452k total,   313284k used,  3321168k free,    71308k buffers
Swap:   505896k total,        0k used,   505896k free,   220272k cached

I find this pretty alarming - can somebody please enlighten me?
Please include me on CC.
Thanks,
M.
