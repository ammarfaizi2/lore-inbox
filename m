Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272001AbTHHWE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 18:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272042AbTHHWE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 18:04:28 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:24580 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S272001AbTHHWEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 18:04:22 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] 2.6: races between modprobe and depmod in rc.sysinit
Date: Sat, 9 Aug 2003 01:19:19 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030802003007.6D00D2C2AF@lists.samba.org>
In-Reply-To: <20030802003007.6D00D2C2AF@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308090119.20010.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 August 2003 04:29, Rusty Russell wrote:
> In message <200308020122.55169.arvidjaar@mail.ru> you write:
> > anyway here is patch against 0.9.13-pre that makes depmod output in temp
> > file and rename it after. It fixed the problem for sure for me (like
> > commenting out depmod in rc.sysinit did but most people seem to object to
> > it).
>
> Thanks, I've applied this with a fix (you left the declaration of
> skipchars in main(), so it shadowed the new global one).
>
> I also repaired the testsuite after this patch (and found another bug
> along the way), which also would have caught the mistake (Hint hint!).
>

thank you :)

> I've put the lot up in the usual place, masquerading as 0.9.13-pre2.
>
> 	http://www.kernel.org/pub/linux/kernel/people/rusty/modules/module-init-to
>ols-0.9.13-pre2.tar.gz
>
> Feedback welcome!

runs just fine. May I humbly ask for consistent naming scheme in future? 
Jumping from "pre" to "pre2" does not make packaging task easier :)

-andrey
