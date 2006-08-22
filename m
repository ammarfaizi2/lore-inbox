Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWHVVgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWHVVgW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWHVVgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:36:22 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:28669 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP
	id S1751303AbWHVVgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:36:21 -0400
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: "Bill Davidsen" <davidsen@tmr.com>
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
Date: Tue, 22 Aug 2006 23:36:12 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-mips@linux-mips.org,
       Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>
References: <200608102318.04512.thomas.koeller@baslerweb.com> <200608172230.30682.thomas.koeller@baslerweb.com> <44E5BE77.9040200@tmr.com>
In-Reply-To: <44E5BE77.9040200@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608222336.12137.thomas.koeller@baslerweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 15:19, Bill Davidsen wrote:
>
> Don't take it personally, just write working code people can patch in.
> When your code has the features you mentioned it will be highly useful
> and hopefully ported to many devices. I guess security monitoring is an
> "industrial image processing application," which interests me. At the
> moment I would call it an impressive proof of concept, but you have many
> useful ideas for its future.

I am not offended at all, I certainly agree with Pavel's opinion of 'do
not invent new interfaces needlessly'. But this is a use case significantly
different from what the v4l2 api is aimed at.

As I wrote earlier, if it were not for other reasons, then changing the
API is not an option because the software already ships. I can place the
driver somewhere else in the kernel tree. I can fix any issues that
someone may find with it. I certainly cannot replace it with something
entirely different. If it is rejected, my only option is to submit the
rest of the code, without the capturing driver (the platform is already
in the kernel tree). Some may feel that a camera that cannot capture
images is somewhat pointless, though...

Of course, everyone is free to write a v4l2 driver, but will likely
find that the hardware is not very suitable as a streaming video
device. At least, it would be a very expensive one...

Thomas

-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
