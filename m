Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279643AbRJXX3B>; Wed, 24 Oct 2001 19:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279645AbRJXX2o>; Wed, 24 Oct 2001 19:28:44 -0400
Received: from bugs.unl.edu.ar ([168.96.132.208]:54999 "HELO bugs.unl.edu.ar")
	by vger.kernel.org with SMTP id <S279643AbRJXX2O>;
	Wed, 24 Oct 2001 19:28:14 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Mart=EDn=20Marqu=E9s?= <martin@bugs.unl.edu.ar>
To: "Marc Brekoo" <kernel@brekoo.no-ip.com>
Subject: Re: howto see shmem
Date: Wed, 24 Oct 2001 20:27:43 -0300
X-Mailer: KMail [version 1.3]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011024214017.E5B1D2AB49@bugs.unl.edu.ar> <005001c15ce2$1123aec0$0500a8c0@brekoo.noip.com>
In-Reply-To: <005001c15ce2$1123aec0$0500a8c0@brekoo.noip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011024232744.F14D62AB49@bugs.unl.edu.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mié 24 Oct 2001 20:17, Marc Brekoo wrote:
> Hi,
>
> >I have found out that /proc/meminfo doesn't have (at least that's my first
> >thought) info about shared memory (it shows 0, even in heavy duty
> > servers). ipcs also shows nothing, so how can I see the amount of shared
> > memory being used?
> >Th mounted /dev/shmem device also shows 0 kb used (just in case).
>
> AFAIK you can't. Calculating how much shared mem is used in 2.4.x is just
> too hard...

And this:

# ipcs
 
------ Shared Memory Segments --------
key       shmid     owner     perms     bytes     nattch    status
0x00000000 65536     nobody    600       46084     11        dest
 
------ Semaphore Arrays --------
key       semid     owner     perms     nsems     status
0x00000000 393216    nobody    600       1
 
------ Message Queues --------
key       msqid     owner     perms     used-bytes  messages
 
#

I can see 46084 bytes in shared memory used by the apache.
Am I wrong?

Saludos... :-)

-- 
Porqué usar una base de datos relacional cualquiera,
si podés usar PostgreSQL?
-----------------------------------------------------------------
Martín Marqués                  |        mmarques@unl.edu.ar
Programador, Administrador, DBA |       Centro de Telematica
                       Universidad Nacional
                            del Litoral
-----------------------------------------------------------------
