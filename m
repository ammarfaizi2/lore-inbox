Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSGHPKl>; Mon, 8 Jul 2002 11:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSGHPKk>; Mon, 8 Jul 2002 11:10:40 -0400
Received: from adsl-161-92.barak.net.il ([62.90.161.92]:22803 "EHLO
	qlusters.com") by vger.kernel.org with ESMTP id <S316797AbSGHPKj>;
	Mon, 8 Jul 2002 11:10:39 -0400
Subject: Re: Kernel Ooops
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Matthias Fricke <matthiasfricke@onetel.net.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D29A2D9.CD8936DB@onetel.net.uk>
References: <3D29A2D9.CD8936DB@onetel.net.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 08 Jul 2002 18:12:19 +0300
Message-Id: <1026141140.5287.45.camel@sake>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-08 at 17:34, Matthias Fricke wrote:
> Hallo,
> 
> I am using 2.4.18 Kernel on a 512MB RAM Mashine.
> Kernel detects only 256 MB.
> If I am booting lilo with mem=512M the kernel Ooopses and panics.
> 
> The kernel is patched with kernel patch of kernel.org from februar 18
> th.

>From my experience this usually means that the system in question has a
display card that uses some of the main memory. SInce I see this is a
laptop this makes even more sense. Try booting with mem=504M or less (if
your display card uses more memory) and there's a good chance that the
panic will go away.

Cheers,
Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
Code mangler, senior coffee drinker and VP SIGSEGV
Qlusters ltd.

"You got an EMP device in the server room? That is so cool."
      -- from a hackers-il thread on paranoia



