Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWCTTKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWCTTKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWCTTKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:10:35 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:16207 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965052AbWCTTKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:10:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KePqKnOFt3ehr0zafO8MJUs/2y12F7d6pYgcWU+qn8Og1bw3UftKrmrMlrqaRCWbnKh0nIND0LRnbxH8RUdG6yfj82b/Yj2NGnIjlMdiUSaj+Yw5ocHUQT/idmgQhY07uQBXSp5jczYkNyT0TfAm1Usb4gZc1taBoTKIp43W7gU=
Message-ID: <441EFE54.2090004@gmail.com>
Date: Mon, 20 Mar 2006 21:11:16 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060319)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Peter Wainwright <prw@ceiriog.eclipse.co.uk>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announcing crypto suspend
References: <20060320080439.GA4653@elf.ucw.cz> <1142879707.9475.4.camel@localhost.localdomain> <200603201954.45572.rjw@sisk.pl>
In-Reply-To: <200603201954.45572.rjw@sisk.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> and please read the HOWTO.  Unfortunately the RSA-related part hasn't been
> documented yet, but it's pretty straightforward.

Hello,

I don't understand why you are working so hard on this... If
you want encryption, you should care about all of your data!

And if you encrypt all your data, you automatically get a
suspend image encryption...

Please have a look at
http://wiki.suspend2.net/EncryptedSwapAndRoot

I use loop-aes in order to do the job... I know... I know...
You don't like suspend2... But it should be basically the
same with swsusp1/2/3/N.

Best Regards,
Alon Bar-Lev.
