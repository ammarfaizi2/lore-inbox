Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268756AbUJUQTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268756AbUJUQTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268714AbUJUQQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:16:17 -0400
Received: from mail.aknet.ru ([217.67.122.194]:9996 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S270775AbUJUQIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:08:38 -0400
Message-ID: <4177E0C3.2040200@aknet.ru>
Date: Thu, 21 Oct 2004 20:16:03 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X does not start. vm86old returns ENOSYS?? -- solved
References: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua> <200410211515.48035.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410211515.48035.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Denis Vlasenko wrote:
> Turned out that Mandrake was working because it was booted
> via lilo whereas "my" Linux was booted via DOS-based loader.
> When I started "my" Linux via lilo, everything worked just fine.
Have you tried the "vga_reset" tool of
svgalib? It is intended to solve exactly
that problem (but it doesn't seem to work
right with some modern video cards like mine).

> Heh. Proper solution is probably to teach X to not use int10.
It also looks like int10 module of XFree
could check whether or not the int vector
is really pointing to the vbios, before
calling it.

