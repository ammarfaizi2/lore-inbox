Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWDMOxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWDMOxv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDMOxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:53:51 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:32898 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750742AbWDMOxu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:53:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dLbvPsnJ63EI/v2/kknbK1whY27uVHInuSxjnHE0ewOYWQ/3+eq1/e4hieboUlXy2Ki/eE02TdVsaL5Q/LMWqA0V7r00PhqxAc2c8Xn3GUVmPUF53sF9AgtkxRWLRByi4bvOKjjNFvAl77tid1cc6zuHQQstd3wDksxxz2Sc4i0=
Message-ID: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>
Date: Thu, 13 Apr 2006 07:53:50 -0700
From: "K P" <kplkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: JVM performance on Linux (vs. Solaris/Windows)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun's recently published SPECjbb_2005 numbers on Linux, Windows and
Solaris on their
Opteron system, and the Linux result is the lowest of the three by far:

Linux: http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00062.html
Solaris: http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00063.html
Windows: http://www.spec.org/jbb2005/results/res2006q1/jbb2005-20060117-00064.html

It's not evident if Sun spent any time analyzing and tuning the Linux
result. While the
majority of the tuning opportunities for SPECjbb_2005 are likely to be
in the JVM itself, I was
wondering (given the large spread between the OS's) if there were
other typical opportunities
to tune the Linux kernel for JVM performance and SPECjbb_2005.

There are some other results showing excellent scalability with SPECjbb_2005 on
Linux/Itanium (such as SGI's:
http://www.spec.org/jbb2005/results/res2006q2/ ), but it's
not clear if there are other opportunities for tuning unique to Linux
on Opteron, or Linux
in general that should be explored

Comments?

-kp
