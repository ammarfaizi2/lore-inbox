Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130455AbQJ0Avm>; Thu, 26 Oct 2000 20:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbQJ0Avc>; Thu, 26 Oct 2000 20:51:32 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:9732 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130455AbQJ0AvX>; Thu, 26 Oct 2000 20:51:23 -0400
Message-ID: <39F8D0B3.B2B6D520@timpanogas.org>
Date: Thu, 26 Oct 2000 18:47:47 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: killing read_ahead[]
In-Reply-To: <39F5999B.91DDC98@evision-ventures.com> <39F8C0BA.CF0F284D@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Jeff V. Merkey" wrote:
> 
> Martin,
> 
> A lot of changes.  Have you tested this adequately?   Changes of this
> magnitude this late in the 2.4 cycle could break a lot of stuff.  I'll
> apply your patch, and let you know.
> 
> :-)
> 
> Jeff

Martin,

1.  Adaptec SCSI driver on a 4 x P6 POCA blows up with timeout errors
then hard hangs machine.
2.  DVD-RAM drive gets scsi timeout errors on AMD K6 System.
3.  Cannot see the MASHITA RW-CDROM with ide-scsi loaded with patch.
4.  2.4.0 hard locks on dual processor PIII 400Mhz during kernel boot.

:-)

Well, I tried the patch.  Looks like some SMP issues of some kind.  

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
