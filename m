Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268709AbUJUMSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbUJUMSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268703AbUJUMQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:16:18 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:43018 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S270009AbUJUMOd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:14:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Stas Sergeev <stsp@aknet.ru>
Subject: Re: X does not start. vm86old returns ENOSYS?? -- solved
Date: Thu, 21 Oct 2004 15:15:47 +0000
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200410211515.48035.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 October 2004 16:53, Denis Vlasenko wrote:
> Hi Stas, all,
>
> I have put my hard drive, which holds working desktop
> Linux system, into another box.
> Linux starts w/o problem, but X does not.
>
> Video is an i845. Madrake 9 install on the same box
> starts X just fine.
>
> I booted into 'my' Linux again, mounted partition
> with working Mandrake, chrooted into it, tried to start X.
> The same result, does not work.

Turned out that Mandrake was working because it was booted
via lilo whereas "my" Linux was booted via DOS-based loader.

When I started "my" Linux via lilo, everything worked just fine.

Heh. Proper solution is probably to teach X to not use int10.
--
vda
