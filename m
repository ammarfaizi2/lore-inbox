Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbRGKGPb>; Wed, 11 Jul 2001 02:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbRGKGPV>; Wed, 11 Jul 2001 02:15:21 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:51925 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S267209AbRGKGPH>; Wed, 11 Jul 2001 02:15:07 -0400
Message-ID: <3B4BEF6E.E8D6C155@idcomm.com>
Date: Wed, 11 Jul 2001 00:17:18 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: ADAPTEC AHA 29160N
In-Reply-To: <001401c10998$6c1e7960$8364f9c8@elogica.com.br>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Igor Maciel Macaúbas wrote:
> 
> Hello Everybody,
> I'm in trouble with this SCSI controller.
> I tried, but it's impossible to set up some version of linux with this SCSI
> controller.
> I need help .. is this device supported by the actual version of kernels?
> What the hell is happening?
> I've tried to install Mandrake (8.0), Red Hat (5.1, 6.0, 6.2), tried with
> Debian too, and will try with Redhat 7.0 and 7.1
> How can I get it working?
> 
> []'z
> Igor
> --
> igor@br.inter.net
> igor@nlink.com.br
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I don't know about this separate version of the controller, but the
integrated versions of the 29160 work with the aic7xxx controller. There
was some discussion a while back about the "rebuild firmware" option
during kernel config, I suspect on regular and current kernels it is not
needed; it was, however, required on some of the XFS patched kernels. Is
the "N" version the 32 bit pci version (as opposed to the 64 bit pci
slot versions)? If it fails to work, I'd wonder more if it is a pci
setup issue than aic7xxx.

D. Stimits, stimits@idcomm.com
