Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130210AbQKLH3b>; Sun, 12 Nov 2000 02:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130215AbQKLH3W>; Sun, 12 Nov 2000 02:29:22 -0500
Received: from slc97.modem.xmission.com ([166.70.9.97]:50951 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130210AbQKLH3J>; Sun, 12 Nov 2000 02:29:09 -0500
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001109113524.C14133@animx.eu.org> <m1g0kycm0x.fsf@frodo.biederman.org> <8ukaeb$eh6$1@cesium.transmeta.com> <m13dgycaqh.fsf@frodo.biederman.org> <3A0DE517.3EAF1099@transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2000 23:31:20 -0700
In-Reply-To: "H. Peter Anvin"'s message of "Sat, 11 Nov 2000 16:32:23 -0800"
Message-ID: <m1y9ypbt1j.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@transmeta.com> writes:

> "Eric W. Biederman" wrote:
> > 
> > Hmm.  You must mean similiar to milo.
> > 
> > Have fun.  With linuxBIOS I'm working exactly the other way.  Killing
> > off the BIOS.  And letting the initial firmware be just a boot loader.
> > The reduction is complexity should make it more reliable.
> > 
> 
> ... except that you have to handle every single motherboard architecture
> out there now.

Agreed that is a bit of a risk.  Mostly you just have to handle
the chipset of the boards and there are a finite number of them.

Only time will tell if this is truly feasible.  I think it is certainly
work a try.  

And I don't have to handle every single one just all of the ones
I need it to run on :)

With the my kexec patch I'm just getting the infrastructure ready, and that
is functionality that can be used independently of linuxBIOS.  If
booting linux from linux would help with what you are doing I love to
work together on that.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
