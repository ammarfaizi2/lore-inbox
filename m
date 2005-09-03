Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbVICWZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbVICWZX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 18:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVICWZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 18:25:23 -0400
Received: from pD9F86CE8.dip0.t-ipconnect.de ([217.248.108.232]:32641 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S1751274AbVICWZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 18:25:22 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: linux.kernel
Subject: Re: forbid to strace a program
Date: Sun, 04 Sep 2005 00:23:50 +0200
Organization: privat
Message-ID: <dfd7pm$1c2$1@pD9F86CE8.dip0.t-ipconnect.de>
References: <4IExJ-4aE-21@gated-at.bofh.it> <4IMY1-7C1-19@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@arcor.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.11) Gecko/20050806
X-Accept-Language: de, en-us, en
In-Reply-To: <4IMY1-7C1-19@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:
> On 9/3/05, Andreas Hartmann <andihartmann@01019freenet.de> wrote:
>> Hello!
>> 
>> Is it possible to prevent a program to be straced on x86?
>> What do I have to do, eg., to prevent a perl-program to be straced?
>> 
> 
> So that none can see what are you doing? Or because your program is
> breaking because of this? Probably nothing, but someone would like
> to know what it is you are doing and exactly how it breaks (and, if
> you don't mind -
> why it breaks).

That's not really the problem. I want to hide a clear text password in
that program (something like ssh-agent or gpg-agent; the last can be
straced, too :-() which I need for a database when the program runs.

Is there another way to do this? If the password is crypted, I need a
passphrase or something other to decrypt it again. Not really a solution
of the problem.

Therefore, it would be best, to hide it by preventing stracing of the
application to all users and root.

Ok, root could search for the password directly in the memory, but this
would be not as easy as a strace.



Kind regards,
Andreas Hartmann
