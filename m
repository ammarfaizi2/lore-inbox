Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279647AbRJXXkv>; Wed, 24 Oct 2001 19:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279648AbRJXXkb>; Wed, 24 Oct 2001 19:40:31 -0400
Received: from bugs.unl.edu.ar ([168.96.132.208]:63703 "HELO bugs.unl.edu.ar")
	by vger.kernel.org with SMTP id <S279647AbRJXXkZ>;
	Wed, 24 Oct 2001 19:40:25 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Mart=EDn=20Marqu=E9s?= <martin@bugs.unl.edu.ar>
To: Robert Love <rml@tech9.net>
Subject: Re: howto see shmem
Date: Wed, 24 Oct 2001 20:39:57 -0300
X-Mailer: KMail [version 1.3]
Cc: Marc Brekoo <kernel@brekoo.no-ip.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011024214017.E5B1D2AB49@bugs.unl.edu.ar> <20011024232744.F14D62AB49@bugs.unl.edu.ar> <1003966646.3520.110.camel@phantasy>
In-Reply-To: <1003966646.3520.110.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011024233958.A58AB2AB49@bugs.unl.edu.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mié 24 Oct 2001 20:37, Robert Love wrote:
> On Wed, 2001-10-24 at 19:27, Martín Marqués wrote:
> > [...]
> > ------ Shared Memory Segments --------
> > key       shmid     owner     perms     bytes     nattch    status
> > 0x00000000 65536     nobody    600       46084     11        dest
> > [...]
> > I can see 46084 bytes in shared memory used by the apache.
> > Am I wrong?
>
> Nope.  Applications know how much the are sharing because they can
> easily see what region of memory is shared/mapped into their's.
>
> The reason the kernel can't figure out the net shared memory is because
> there is no simple way -- it has to add up the shared regions of all
> applications, counting each shared segment only once.  Too much work.

Yes, I guess you are right. I just checked on and old RH server with a 2.2.x 
kernel, and the sum of the shared memory of each application doesn't give me 
the amount of shared memory that free gives me.

Thanks to all!

-- 
Porqué usar una base de datos relacional cualquiera,
si podés usar PostgreSQL?
-----------------------------------------------------------------
Martín Marqués                  |        mmarques@unl.edu.ar
Programador, Administrador, DBA |       Centro de Telematica
                       Universidad Nacional
                            del Litoral
-----------------------------------------------------------------
