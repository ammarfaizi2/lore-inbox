Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVG0Ooj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVG0Ooj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVG0Ooj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:44:39 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:20206 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261288AbVG0Ooh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:44:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L+tOUtzCe3gGtcHcWae10bT6S/W2aJ8Adjvte0sAq0fxAYzbmFtYeLw2mNsVabKu9cpRfkvOm267ZlF1IiH0JEOjUQGVUXFo7LA8dSUlqFUUdxsEcUJA4K2gyMqdbg+MxMaXEzjj0V8x6QiXSj0QjPaauIQzmLM88bigUlfckLo=
Message-ID: <88e823ff050727074411651351@mail.gmail.com>
Date: Wed, 27 Jul 2005 08:44:35 -0600
From: Brad Davis <enrock@gmail.com>
Reply-To: Brad Davis <enrock@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: US Robotics (Hardware) Modem Not Detected
In-Reply-To: <20050727145747.A29785@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88e823ff0507270645613b1ca@mail.gmail.com>
	 <20050727145747.A29785@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> serial8250_init does not contain any such message, so you're not
> running a mainline kernel, but some patched version.  Are these
> patches available somewhere?

I'm compiling from the Ubuntu (based on Debian) sources. I'll either
download a clean kernel source tonight and try it out or try remove
the patches to the serial driver and try that.
 
> I guess these patches are your problem, and it seems that there's
> at least one which is completely unnecessary or inappropriate.

Thanks for the help, I'll post my results.

Brad
-- 
enrock@gmail.com
