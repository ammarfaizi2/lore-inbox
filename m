Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSJVIvb>; Tue, 22 Oct 2002 04:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJVIvb>; Tue, 22 Oct 2002 04:51:31 -0400
Received: from pc132.utati.net ([216.143.22.132]:53888 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262298AbSJVIva> convert rfc822-to-8bit; Tue, 22 Oct 2002 04:51:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
Date: Mon, 21 Oct 2002 22:57:40 -0500
User-Agent: KMail/1.4.3
Cc: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
References: <m1k7kfzffk.fsf@frodo.biederman.org> <m1ptu3t3ec.fsf@frodo.biederman.org> <m1fzuyub3z.fsf@frodo.biederman.org>
In-Reply-To: <m1fzuyub3z.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210212257.40050.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 October 2002 03:33, Eric W. Biederman wrote:

> j < Printed from the second callback in setup.S, just before the
> kernel decompresser is run >
>
>
> I have a very strange node that makes it all of the way to 'j' before
> rebooting. The concept that something is dying in protected mode will all
> of the interrupts disabled is so novel that I really don't know what to
> make of it, yet.

It would almost have to be the MMU.  Any way to dump the page tables?

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
