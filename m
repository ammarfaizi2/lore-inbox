Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293089AbSBWCW6>; Fri, 22 Feb 2002 21:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293084AbSBWCWq>; Fri, 22 Feb 2002 21:22:46 -0500
Received: from are.twiddle.net ([64.81.246.98]:34447 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S293083AbSBWCWg>;
	Fri, 22 Feb 2002 21:22:36 -0500
Date: Fri, 22 Feb 2002 18:22:31 -0800
From: Richard Henderson <rth@twiddle.net>
To: Steffen Persvold <sp@scali.com>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
Message-ID: <20020222182231.A16628@twiddle.net>
Mail-Followup-To: Steffen Persvold <sp@scali.com>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org> <20020220103539.B32211@vger.timpanogas.org> <3C73DC34.E83CCD35@mandrakesoft.com> <20020220.093034.112623671.davem@redhat.com> <20020220110004.A32431@vger.timpanogas.org> <20020220145449.A1102@vger.timpanogas.org> <20020220151053.A1198@vger.timpanogas.org> <3C7626A9.330A9249@scali.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C7626A9.330A9249@scali.com>; from sp@scali.com on Fri, Feb 22, 2002 at 12:08:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 12:08:25PM +0100, Steffen Persvold wrote:
> I think you'll have to check again. In LP64 programming models (used on most
> 64-bit OS'es) 'long' is 64 bit. Thus a 'unsigned long' is always safe to use
> for pointer arithmetic since it will be 32 bit on 32bit machines and 64bit on
> 64bit machines.

This isn't something you should count on universally.  There
are targets that have a 64-bit long, but a 32-bit pointer.

Seems unlikely to show up on linux, but...


r~
