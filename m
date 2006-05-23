Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWEWSjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWEWSjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWEWSi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:38:59 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:23824 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S932250AbWEWSi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:38:59 -0400
Message-ID: <447356BF.2080000@rainbow-software.org>
Date: Tue, 23 May 2006 20:38:55 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Antonio <tritemio@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [radeonfb]: unclean backward scrolling
References: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com>
In-Reply-To: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio wrote:
> Hi,
> 
> I'm using the radeonfb driver with a radeon 7000 with the frambuffer
> at 1280x1024 on a i386 system, with a 2.6.16.17 kernel. At boot time,
> if I stop the messages with CTRL+s and try look the previous messages
> with CTRL+PagUp (backward scrolling) the screen become unreadable. In
> fact some lengthier lines are not erased scrolling backward and some
> random characters a overwritten instead. So it's very difficult to
> read the messages.
> 
> I don't have such problem with the frambuffer at 1024x768.
> 
> All the previous kernels I've tried have this problem (at least up to 
> 2.6.15).
> 
> If someone can look at this issue I can provide further information.

I have probably the same problem - but with vesafb on my notebook 
(800x600). When I scroll back/forward or run mc and then exit, it fixes 
itself. The problem was probably always there (in 2.6.x - don't know 
about older versions).

-- 
Ondrej Zary
