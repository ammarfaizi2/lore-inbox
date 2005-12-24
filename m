Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVLXVy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVLXVy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 16:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVLXVy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 16:54:29 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:1974 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750733AbVLXVy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 16:54:28 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Have menuconfig use ncursesw
Date: Sat, 24 Dec 2005 21:54:42 +0000
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0512242240000.29877@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0512242240000.29877@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512242154.42189.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2005 21:42, Jan Engelhardt wrote:
> Hi,
>
>
> on vgacon (standard tty1 stuff) with UTF8 enabled, running make menuconfig
> gives ascii-art lines `a la + - and |. I use the following patch to get
> back the line graphics from the upper part of the font. AFAICS this should
> have no impact on non-utf consoles. Include it in mainline?
>

Not everybody has libncursesw, therefore such a patch should runtime detect 
whether such a library is available before unconditionally linking against 
it.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
