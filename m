Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132633AbRDCWj7>; Tue, 3 Apr 2001 18:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbRDCWjs>; Tue, 3 Apr 2001 18:39:48 -0400
Received: from unimur.um.es ([155.54.1.1]:9674 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S132633AbRDCWj2>;
	Tue, 3 Apr 2001 18:39:28 -0400
Message-ID: <3ACA55D5.FC2E444C@ditec.um.es>
Date: Wed, 04 Apr 2001 00:59:33 +0200
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.76 [es] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SOLVED]Re: 2.2.19 && ppa: total lockup. No problem with 2.2.17
In-Reply-To: <20010330152921.Q10553@redhat.com> <Pine.LNX.4.21.0103310156530.23634-100000@ditec.um.es> <20010403173839.I9355@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh escribió:
> 
> On Sat, Mar 31, 2001 at 01:59:39AM +0200, Juan Piernas Canovas wrote:
> 
> > Yes!!!. It works. I am happy now :-)
> 
> Unfortunately, the problem isn't solved, merely worked around.  We
> need to figure out why this is happening in the first place.
:-(

> 
> To recap, the system hangs completely when you load the ppa module.
Right

> 
> Are you using any special parport/ppa parameters?  Is this an SMP or a
> uniprocessor machine?  Come to that, which architecture is it?
> 
I have the same problem in two different machines but they both are UP.
However, my kernel configuration has SMP support enabled.

My modules.conf file is:

alias scsi_hostadapter ppa
alias parport_lowlevel parport_pc
options parport_pc io=0x378 irq=7


> Are there any messages displayed to the console when the hang happens?
> If you could scatter some printks around (KERN_CRIT so they show up on
> the console) to figure out the example point at which it's hanging,
> that would be great.

I stop klogd and syslogd services (that causes to display all kernel
messages on screen, doesn't it? and, when I load the ppa modules, the
machine simply hangs: no messages, no sysreq key anymore.

Bye!

	Juan.

-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
