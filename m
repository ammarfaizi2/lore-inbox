Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVCNSGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVCNSGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVCNSEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:04:01 -0500
Received: from mail.aknet.ru ([217.67.122.194]:776 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261659AbVCNSCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:02:45 -0500
Message-ID: <4235D1CD.1040304@aknet.ru>
Date: Mon, 14 Mar 2005 21:02:53 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Jakob Eriksson <jakov@vmlinux.org>
Cc: Andi Kleen <ak@muc.de>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@redhat.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       wine-devel@winehq.org, torvalds@osdl.org, the3dfxdude@gmail.com
Subject: Re: [patch] x86: fix ESP corruption CPU bug
References: <42348474.7040808@aknet.ru> <20050313201020.GB8231@elf.ucw.cz>	<4234A8DD.9080305@aknet.ru>	<Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>	<Pine.LNX.4.58.0503131614360.2822@ppc970.osdl.org>	<423518A7.9030704@aknet.ru> <m14qfey3iz.fsf@muc.de> <4235AC0B.70507@vmlinux.org>
In-Reply-To: <4235AC0B.70507@vmlinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jakob Eriksson wrote:
> A long term goal of wine is to support DOS apps to. Of course
> it's not a priority, but it's there.
Yes, that's exactly what I was hoping
for, thanks!
Even if no Windows apps do such a thing
(which wasn't confirmed yet), Wine may
still need that fix for the DOS support
in the future, and dosemu seems to be in
need of that fix already and for long
(that's where I am getting the use of it).
And we haven't heard a word for a VMWare
yet, and I think they may appreciate that
too.
Also, since the first version of the path,
I've been contacted by a few people asking
me to provide an updated version for 2.6.9
and 2.6.10. I don't know the reason, but
I know it was used (I think they were more
concerned about an aforementioned "information
leak", rather than about the %esp corruption).
So if the last problem with that patch was
that it is not really needed, I think it
no longer stays:)

