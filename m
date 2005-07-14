Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263119AbVGNTia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263119AbVGNTia (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbVGNTfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:35:54 -0400
Received: from oban.u-picardie.fr ([193.49.184.8]:26434 "EHLO
	mailx.u-picardie.fr") by vger.kernel.org with ESMTP id S261700AbVGNTew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:34:52 -0400
Message-ID: <1121369685.42d6be556505f@webmail.u-picardie.fr>
Date: Thu, 14 Jul 2005 21:34:45 +0200
From: FyD <fyd@u-picardie.fr>
To: linux-kernel@vger.kernel.org
Subject: Problem with kernel 2.6.11
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 137.131.252.204
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I have a problem with a program named Gaussian (http://www.gaussian.com)
(versions g98 or g03) and FC 4.0 (default kernel 2.6.11): I am used to take
Gaussian binaries compiled on the RedHat 9.0 version, and used them on FC 2.0
or FC 3.0. If I try to do so, on FC 4.0. (with the default kernel) Gaussian
stops (both g98 and g03 versions) with the following error message:

[fyd@localhost ~]$ g98 < toto-g98.com> toto-g98.log
[fyd@localhost ~]$ g03 < toto-g03.com> toto-g03.log
Erroneous write during file extend. write 208 instead of 4096
Probably out of disk space.
Write error in NtrExt1: No such file or directory

And obviously, I do _not_ have any problem of space and no NFS server on my
machine...

Now if I compile and use the kernel 2.6.12, this message dispears and the
program Gaussian g98 works fine, but I still have problems with the version g03
which stops without providing any message...

>From my tests, it seems to be a problem relative to the kernel. Being not a
programmer, it is difficult for me to imagine the problem, and even to describe
it...

Any idea what could be the problem ? Any suggestions about options I should
use/not_use in the kernel, or about a specific kernel 2.6 version I should use
?

Thank you, best regards, Francois

PS Please add my email address in CC since I did not register...

