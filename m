Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVCMTLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVCMTLa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 14:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVCMTL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 14:11:29 -0500
Received: from mail.aknet.ru ([217.67.122.194]:40463 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261426AbVCMTLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 14:11:22 -0500
Message-ID: <42349068.4030405@aknet.ru>
Date: Sun, 13 Mar 2005 22:11:36 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
References: <42348474.7040808@aknet.ru> <Pine.LNX.4.62.0503131950190.23588@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.62.0503131950190.23588@alpha.polcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Grzegorz Kulewski wrote:
> Does the bug also egsist on AMD CPU's?
Yes. As well as the ones of a Transmeta etc.
I just haven't tested the old Cyrixes, that
AFAIK were trying to ignore some Intel bugs.
The test-case for the bug is here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/0690.html

> Does the patch add anything to 
> kernels compiled for AMD CPU's?
Same as for the Intel ones - unless you are
a dosemu or, in a lesser extent, Wine user -
nothing except for fixing the small "information
leak".
If you are the dosemu user however, then this
patch adds a lot. Whether or not it adds
something for the VMWare users I can't say, since
I am not the one of them, but my guess is that
it can help with the DOS programs under it. 

