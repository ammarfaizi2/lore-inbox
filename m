Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTAWM5v>; Thu, 23 Jan 2003 07:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTAWM5v>; Thu, 23 Jan 2003 07:57:51 -0500
Received: from mail.ithnet.com ([217.64.64.8]:11023 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S265171AbTAWM5v>;
	Thu, 23 Jan 2003 07:57:51 -0500
Date: Thu, 23 Jan 2003 14:06:28 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: MB without keyboard controller / USB-only keyboard ?
Message-Id: <20030123140628.3a76fdd9.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33L2.0301160805110.9551-100000@dragon.pdx.osdl.net>
References: <20030116120324.2b97e010.skraw@ithnet.com>
	<Pine.LNX.4.33L2.0301160805110.9551-100000@dragon.pdx.osdl.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003 08:18:04 -0800 (PST)
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> I posted a patch to 2.4.20 on 2002-Dec-04 that might work for you.
> It's available at
>   http://www.osdl.org/archive/rddunlap/patches/kbc_option_2420.patch
> 
> It might work for you.  If you try it out, please let me know how it
> does for you.

Hello Randy,

we checked your patch and it works as you expected, only it is not what we are
looking for. We would like to be able to make _one_ kernel, that can be used on
boards with PS/2 keyboard or USB keyboard, but without a PS/2 keyboard check
that takes as long as it does in current version (and gives _one_ warning, but
not tens).
Do you think this is solvable?

-- 
Regards,
Stephan
