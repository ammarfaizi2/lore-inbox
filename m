Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVDAQ2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVDAQ2K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVDAQ2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:28:09 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:45637 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261793AbVDAQ2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:28:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DdFjV7O/taMndkjIPHFliZZodyra+wIwHinZtbizULfseUez7id83uUJUE9fN8RkLrhgyc/ZbBL8WMSG4kk70QS46cVm4EbafSSM3Rj+RDgYYimvOdzq4yLEq+dNp/NmEUCFWGupVm5ekI3fQakxKxFDEEr+SDucvox43niZ+kE=
Message-ID: <d120d5000504010828152031a@mail.gmail.com>
Date: Fri, 1 Apr 2005 11:28:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: 2.6.12-rc1 swsusp broken [Was Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel]
Cc: romano@dea.icai.upco.es, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <40f323d0050401081423650536@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050329110309.GA17744@pern.dea.icai.upco.es>
	 <d120d5000503310715cbc917@mail.gmail.com>
	 <20050331165007.GA29674@pern.dea.icai.upco.es>
	 <200503311309.50165.dtor_core@ameritech.net>
	 <40f323d0050401081423650536@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 1, 2005 11:14 AM, Benoit Boissinot <bboissin@gmail.com> wrote:
> On Mar 31, 2005 8:09 PM, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > It works, too. Which one is the best one?
> > >
> >
> > Both of them are needed as they address two different problems.
> >
> I tried to boot with the 2 patches applied (and the patch which solves
> noresume) and now touchpad/touchpoint no longer works (with this
> kernel or with an older kernel).
> 

Could you be more explicit - it is not recognized at all or it is
recognized but mouse pointer does not move or something else? dmesg
also might be interesting.

Also, the 2nd "patch" was never published, could you post what exactly
you have applied?

Thanks!

-- 
Dmitry
