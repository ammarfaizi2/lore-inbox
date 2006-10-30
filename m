Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWJ3MOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWJ3MOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWJ3MOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:14:22 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:13219 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751356AbWJ3MOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:14:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cdekt33gFjkSCa9P1+k7ZZKOPDb9+at78oahtWiq0lRvJWaifh0/LNsu2kflisTvdUrF2Loe2jT20mTri8BrGqldV/S9FqLyIWqe8yfnsqpwP1KX9wPBUN5lSdpLupN8GB1IGIO3I/A1kQ6NV16/XSvzp0lLgwin+ay5Co/oTiw=
Message-ID: <1b270aae0610300414u4175fec6i30a1396dde260ca1@mail.gmail.com>
Date: Mon, 30 Oct 2006 13:14:20 +0100
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: user-space command "ipcs" seems broken on 2.6.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the user-space command "ipcs" seems somewhat broken on my 2.6.18.1 as
it doesn't output anything, uses 100% CPU and isn't kill'able.
strace'ing it shows nothing/simply blocks.

Distro is CentOS 4.4, Kernel 2.6.18.1 x86 SMP, gcc version 3.4.6
20060404 (Red Hat 3.4.6-3).
Google didn't turn up anything. Any suggestions to track that down?

Cheers,
M
