Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVDOSEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVDOSEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVDOSEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:04:42 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:43203 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261890AbVDOSEi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:04:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K+bujByURxGUYHEm6IxHs+N8pZrj5Kqp2vAnC+UVljV8KcC4YyRsd4nYEWKYloEZhWJLxwM7gEnoBnfCcrOwJZnyAPNR1vzgI13EzIureX4vkollQgkP6PUvJ3Wq+aeynmlM+IAtHR807rezgFvU2ZGD8YAOO5mb289Mc8ozFBE=
Message-ID: <6533c1c905041511041b846967@mail.gmail.com>
Date: Fri, 15 Apr 2005 14:04:37 -0400
From: Igor Shmukler <igor.shmukler@gmail.com>
Reply-To: Igor Shmukler <igor.shmukler@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: intercepting syscalls
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
We are working on a LKM for the 2.6 kernel.
We HAVE to intercept system calls. I understand this could be
something developers are no encouraged to do these days, but we need
this.
Patching kernel to export sys_call_table is not an option. The fast
and dirty way to do this would be by using System.map, but I would
rather we find a cleaner approach.
I did some research on google and I know this issue has been raised
before, but unfortunately I could not find a coherent answer.
Does anyone know of any tutorial or open source code where I could
look at how this is done? I think that IDT should give me the entry
point, but where do I get system call table address?
Thank you in advance,
Igor
