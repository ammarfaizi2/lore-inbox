Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVGEIc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVGEIc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 04:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVGEIc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 04:32:28 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:34930 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261759AbVGEIXT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 04:23:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s4vK/rZpjQ2lNUhAz72wEfCzk1kSq+aver6fidrZzXQmBeG//SejP27uECGVrpggfbfk+iBVZIiHdPTKHaI3r7vhnFWrzL9ls5X+BXeNZqkMyx/8zP89EF0sM9F99VkLFGP2cR7xd+wXnpgCbCcM+wSBtEznLV5CDWPSeS1QgVk=
Message-ID: <1458d9610507050123124d6cb@mail.gmail.com>
Date: Tue, 5 Jul 2005 16:23:18 +0800
From: S <talk2sumit@gmail.com>
Reply-To: S <talk2sumit@gmail.com>
To: linux-kernel@vger.kernel.org,
       linux prg <linux-c-programming@vger.kernel.org>
Subject: LKM function call on kernel function call?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to code a loadable module having function1(), which
would be called, everytime a particular function of the kernel is
called? If not, atleast a way this could be done without re-compiling
the whole kernel and rebooting the system?

Example:

My LKM:
-------------

init_module() {
...
}

function1() {
...
}

cleanup_module() {
...
}


I want function1() to be called, everytime the function
ide_do_rw_disk() of ide-disk.c is called. I do not want to re-compile
the complete kernel to do this.

Thanks in advance,

Regards,
S
