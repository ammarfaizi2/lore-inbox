Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280837AbRKTHL3>; Tue, 20 Nov 2001 02:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280940AbRKTHLK>; Tue, 20 Nov 2001 02:11:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26984 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280837AbRKTHLD>; Tue, 20 Nov 2001 02:11:03 -0500
To: Tim Hockin <thockin@hockin.org>
Cc: dervishd@jazzfree.com (RaXlNXXez de Arenas Coronado),
        linux-kernel@vger.kernel.org
Subject: Re: LOBOS (kexec)
In-Reply-To: <200111200541.fAK5f9J28091@www.hockin.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2001 23:52:07 -0700
In-Reply-To: <200111200541.fAK5f9J28091@www.hockin.org>
Message-ID: <m1r8qu53zc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@hockin.org> writes:

> > The hard part is not linux booting linux but the passing of the
> > firmware/BIOS tables from one kernel to the next.  Especially those
> > that can only be obtained by a 16bit query.  It is my assumption that
> > after the OS runs you cannot return to the firmware, it's state is
> > hopelessly mangled.  That may not be totally true but it is fairly
> > close to the truth. 
> 
> It is unless you control the firmware.  Our (Cobalt) firmware reserves a
> region of memory which the primary (in-flash) kernel is not made aware of.
> The in-flash kernel can do all the fun things a kernel can do, and then
> return to firmware.

Hmm.  I might have to check it out.  Comparing notes with what you do on
the Cobalt with what I'm doing in linuxBIOS.  Do you happen to have
a url?

But as I want a general solution I don't intend to pick a solution
that depends on the firmware.

Eric
