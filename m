Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130112AbRALLRR>; Fri, 12 Jan 2001 06:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130751AbRALLRH>; Fri, 12 Jan 2001 06:17:07 -0500
Received: from Cantor.suse.de ([194.112.123.193]:43786 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130112AbRALLQt>;
	Fri, 12 Jan 2001 06:16:49 -0500
Mail-Copies-To: never
To: Damien TOURAINE <touraine_english@limsi.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with elf and dynamic loading ...
In-Reply-To: <3A5EDCDC.70306@limsi.fr>
From: Andreas Jaeger <aj@suse.de>
Date: 12 Jan 2001 12:16:10 +0100
In-Reply-To: <3A5EDCDC.70306@limsi.fr>
Message-ID: <u8zogxt405.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Damien TOURAINE writes:

 > Hi !
 > I'm using dynamic library to load some part of a big software (that
 > use several differents modules).

 > The main program fully use the symboles of the shared object (through
 > the dlsym command), however, the functions available in the module are
 > not able to use the symbols of the main program.


 > Is-it a bug of the kernel ?
 > Is-it to avoid a potential hole of security ?
That's a question for glibc - it has nothing to do with the kernel.
To get it to work, your program should be compiled with -Bdynamic.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
