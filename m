Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVFQBrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVFQBrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVFQBrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:47:08 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:23375 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261888AbVFQBrC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:47:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LmSd0g7tz4Zvfx1ECTrlSgftzs1vbjbvaP/1WNXxf/vERjTdrfmUTO7b8OlLjp91HBhf2ujc19GxdPSGYhrMXjhXKVwhZpsMQ8IAbIu/yhAu0zCuV6E42hqHTf09uuFkTVJEkcNtpfdke61AbUvYPMKXH5qVQ8F1D26Z/WPdYBI=
Message-ID: <4ad99e0505061618475716f13c@mail.gmail.com>
Date: Fri, 17 Jun 2005 03:47:00 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Cc: Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42B218C5.9020406@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ad99e0505061605452e663a1e@mail.gmail.com>
	 <42B1F5CB.9020308@g-house.de>
	 <4ad99e0505061615143cc34192@mail.gmail.com>
	 <42B21130.4000608@g-house.de>
	 <4ad99e0505061617052f427ed6@mail.gmail.com>
	 <42B218C5.9020406@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> one question,
> 
>     Can I know what is the problem? 
>:I have 2 tg3 adapters, lots e100's and some Cisco PIX and devices.
> 
> I can try to reproduce it and see if anyone has something to say about it.

Yes please. As I see it. Enable smtp fixup protocol on your cisco pix
(you will need to have a smtp server to point it to), then on some
linux system running with a kernel greater than 2.6.8.1 do a telnet to
the smtp server that is firewalled and try to issue a smtp command.

Note that cisco has a bug report on smtp fixup banner hiding issues in
cisco os 6.3.4 but it should not result in the connection getting
dropped, it also does not explain why this problem does not seam to
exists on kernels prior to 2.6.9.


Regards.

Lars Roland
