Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129841AbQKTR7a>; Mon, 20 Nov 2000 12:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbQKTR7U>; Mon, 20 Nov 2000 12:59:20 -0500
Received: from mail01.onetelnet.fr ([213.78.0.138]:6194 "EHLO
	mail01.onetelnet.fr") by vger.kernel.org with ESMTP
	id <S129841AbQKTR7J>; Mon, 20 Nov 2000 12:59:09 -0500
Message-ID: <3A196CD9.AB946AD3@onetelnet.fr>
Date: Mon, 20 Nov 2000 19:26:33 +0100
From: Fort David <epopo@onetelnet.fr>
Reply-To: epopo@onetelnet.fr
Organization: DLR network
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin.Monate@lri.fr
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
In-Reply-To: <14868.3329.775330.576681@sun-demons>
		<3A15CE34.EF2FE3CC@uow.edu.au> <14873.17358.536711.2282@sun-demons>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Benjamin Monate

> In his message of Sat 18 November, Andrew Morton writes :
> > Try booting with the `noapic' option.  Looks like your APIC
> > is getting itself unprogrammed.  Check that you're not
> > overclocked and not over temperature.
>
> Booting with noapic did not improve anything.
> The processor is not supposed to be overclocked. How can I be sure of
> that ?
>
> Further investigations showed that the problem will occur only when
> Xfree 4.0.1 is running with an smp kenel . Xfree 3.3.6 is ok. Could this
> be a bug in X ?  I thought that the kernel should prevent such a bug
> from locking the computer.
>
> Thank you again for your help.
> --
>

What 's your video card ? Not something running with closed source drivers ?
(namely G-force)
The kernel cannot prevent drivers from locking PCI/AGP bus.

--
%-------------------------------------------------------------------------%
% FORT David,                                                             %
% 7 avenue de la morvandière                                   0240726275 %
% 44470 Thouare, France                                epopo@onetelnet.fr %
% ICU:78064991   AIM: enlighted popo             fort@irin.univ-nantes.fr %
%--LINUX-HTTPD-PIOGENE----------------------------------------------------%
%  -datamining <-/                        |   .~.                         %
%  -networking/flashed PHP3 coming soon   |   /V\        L  I  N  U  X    %
%  -opensource                            |  // \\     >Fear the Penguin< %
%  -GNOME/enlightenment/GIMP              | /(   )\                       %
%           feel enlighted....            |  ^^-^^                        %
%                           http://ibonneace.dnsalias.org/ when connected %
%-------------------------------------------------------------------------%



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
