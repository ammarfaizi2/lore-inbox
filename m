Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293381AbSCJXp2>; Sun, 10 Mar 2002 18:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293385AbSCJXpR>; Sun, 10 Mar 2002 18:45:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13582 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293381AbSCJXpJ>;
	Sun, 10 Mar 2002 18:45:09 -0500
Message-ID: <3C8BF015.606BCCDA@mandrakesoft.com>
Date: Sun, 10 Mar 2002 18:45:25 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Andreas Jaeger <aj@suse.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
In-Reply-To: <1015784104.1261.8.camel@phantasy>  <u8zo1g9nf8.fsf@gromit.moeb> <1015793618.928.17.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Sun, 2002-03-10 at 15:29, Andreas Jaeger wrote:
> 
> > Please add the procinterface also!  I've found it today (for 2.4.18)
> > and it's much easier to use with existing programs.
> 
> I agree and I really like the proc-interface.  There is something uber
> cool about:
> 
>         cat 1 > /proc/pid/affinity
> 
> I have a patch for 2.5.6 for proc-based affinity interface here:
> 
>         http://www.kernel.org/pub/linux/kernel/people/rml/cpu-affinity/v2.5/cpu-affinity-proc-rml-2.5.6-1.patch


Anon!  But there is something uber-ugly about constantly jamming more
and more stuff into procfs without thinking or planning long term...  I
vote for the non-procfs approach :)

-- 
Jeff Garzik      | Usenet Rule #2 (John Gilmore): "The Net interprets
Building 1024    | censorship as damage and routes around it."
MandrakeSoft     |
