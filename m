Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKIBqN>; Wed, 8 Nov 2000 20:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129956AbQKIBqD>; Wed, 8 Nov 2000 20:46:03 -0500
Received: from mail01.onetelnet.fr ([213.78.0.138]:54565 "EHLO
	mail01.onetelnet.fr") by vger.kernel.org with ESMTP
	id <S129044AbQKIBpy>; Wed, 8 Nov 2000 20:45:54 -0500
Message-ID: <3A0A0F76.BEAC838C@onetelnet.fr>
Date: Thu, 09 Nov 2000 03:44:06 +0100
From: FORT David <epopo@onetelnet.fr>
Organization: Derriere les rochers Networks
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: David Ford <david@linux.com>, bpemberton@dingoblue.net.au,
        linux-kernel@vger.kernel.org
Subject: Re: pcmcia
In-Reply-To: <Pine.LNX.4.21.0011091131240.9217-100000@tae-bo.generica.dyndns.org> <3A09FACF.9334A299@linux.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:

> You may be in the same boat I'm in then.  i82365 is what I used and it worked.
> yenta doesn't.  Right now I'm stuck with using my USB nic because neither the
> kernel's pcmcia or dh pcmcia work for me.
>
> -d
>
> Brett wrote:
>
> > Hey,
>

[....]

>
> > > "The difference between 'involvement' and 'commitment' is like an
> > > eggs-and-ham breakfast: the chicken was 'involved' - the pig was
> > > 'committed'."
> > >
> > >
> > >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
>
> --
> "The difference between 'involvement' and 'commitment' is like an
> eggs-and-ham breakfast: the chicken was 'involved' - the pig was
> 'committed'."

I got the same problem for an old 486 with no PCI, as yenta_socket doesn't work, i
have to add CONFIG_I82365
in order to have things work. 'till this is set and recompiled, everything works
perfectly. The controller is a
VLSI 82C146.
I'm problably missing something, but these's two things i don't understand:
-why PCMCIA depends on PCI at compilation time
-why yenta is activated for i82365, as it doesn't do the job i82365 did.


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
