Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWGNKy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWGNKy0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 06:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWGNKy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 06:54:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:59169 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161069AbWGNKyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 06:54:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=hDSvrNXbgrpLPH69wBvByebiWzQEgOqQlj+cn3Ffh4YzRiaibBi46PaOzzyZU2XoEOBpczBbgblhFLjLK32uerUp4IIWAzB9Kp/1kbZpkHmWFeYfV+Gsw5nHIlcr7QCWrFaP0au7mBqMluAneuIakpmD1r3Ff7PxmKuxl1M7y2Q=
Date: Fri, 14 Jul 2006 14:54:21 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Martin van Es <martin@mrvanes.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.17.1 bug/oops in snd_usb_audio subsystem
Message-ID: <20060714105421.GA6831@martell.zuzino.mipt.ru>
References: <200607141154.36939.martin@mrvanes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200607141154.36939.martin@mrvanes.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 11:54:36AM +0200, Martin van Es wrote:
> I already sent this mail to perex@suse.cz a couple of days ago since I thought
> that was the closest match in the MAINTAINERS list for this oops.
> Since I didn't receive any reply

Your kernel is tainted. Please complain to kqemu developers. Don't waste
Jaroslav's time.

> BUG: unable to handle kernel NULL pointer dereference at virtual address
> 000001b8
>  printing eip:
> deae2514
> *pde = 00000000
> Oops: 0002 [#1]
> Modules linked in: snd_usb_audio pwc snd_usb_lib videodev v4l2_common
> snd_rawmidi snd_hwdep capability commoncap kqemu ipw2200

> EIP:    0060:[<deae2514>]    Tainted: P      VLI

