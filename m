Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbUKDRum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbUKDRum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUKDRtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:49:23 -0500
Received: from zamok.crans.org ([138.231.136.6]:27101 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262327AbUKDRqV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:46:21 -0500
To: linux-os@analogic.com
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.9 won't allow a write to a NTFS file-system.
References: <Pine.LNX.4.61.0411041054370.4818@chaos.analogic.com>
	<MPG.1bf47baa1b621da0989706@news.gmane.org>
	<Pine.LNX.4.61.0411041158010.5193@chaos.analogic.com>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Thu, 04 Nov 2004 18:46:21 +0100
In-Reply-To: <Pine.LNX.4.61.0411041158010.5193@chaos.analogic.com>
	(linux-os@chaos.analogic.com's message of "Thu, 4 Nov 2004 12:09:47
	-0500 (EST)")
Message-ID: <87is8l7biq.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> disait dernièrement que :

> On Thu, 4 Nov 2004, Giuseppe Bilotta wrote:
>

> Huh? Are we talking about the same thing?

yes

> I'm talking about
> the NTFS that Windows/NT and later versions puts on its
> file-systems. I use an USB external disk with my M$ Laptop
> and I have always been able to transfer data to/from
> my machines using that drive. Now I can't. The drive it
> writable under M$, but I can't even delete anything
> (no permission for root) under Linux.

Taken from kernel help in *config:
"The only supported operation is overwriting existing files, without changing
the file length. No file or directory creation, deletion or renaming is
possible..."

Best,

Mathieu

-- 
<WeirdArms> erikm: bugger alan cox on a chip, I want alan cox in a book ;)

	- Adam Wiggins on #kernelnewbies

