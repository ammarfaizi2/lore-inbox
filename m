Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161503AbWHDVnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161503AbWHDVnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161504AbWHDVnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:43:15 -0400
Received: from qb-out-0506.google.com ([72.14.204.235]:40095 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161503AbWHDVnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:43:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=reMsUAHattbkxsF5e+3PY48xv8MlXyTb9oCQfW9bxb5+yQGLzz1Ic6JHl3Rbm73BBVfxWIwNxDn7FnLddc3V69Hy0g/fyQoY/i8yiBfj37Dj3+X9RKn2BdllnyJhN/tBolB3hAAzTXwH0Qcxfx0GV32Wjt59MOIZ3SJbLMFG4Ug=
Message-ID: <44D3BF62.10202@gmail.com>
Date: Fri, 04 Aug 2006 23:42:58 +0200
From: RazorBlu <razorblu@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACLs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will these ever be implemented? If so, when? At the moment, all the 
Linux kernel brings (ie. without any external access control systems 
such as grsecurity or RSBAC) are rwx permissions. Even Windows brings 
more finely-grained access controls than this - is that something we 
want to live with?

I for one would like to see more finely-grained access controls 
available out-of-the-box, so to speak. I don't want to have to download 
an LSM plugin or whatnot in order to do it for me. Does it really matter 
which one you choose? Pick the most mature one and be done with it. If 
you choose grsecurity and some RSBAC die-hards still want to use RSBAC, 
let them - but at least have _something_ in the kernel which allows more 
finely-grained controls than rwx.

Adieu.
