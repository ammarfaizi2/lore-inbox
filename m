Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290668AbSARTGp>; Fri, 18 Jan 2002 14:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290780AbSARTGj>; Fri, 18 Jan 2002 14:06:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22578 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290668AbSARTGb>; Fri, 18 Jan 2002 14:06:31 -0500
Date: Fri, 18 Jan 2002 20:07:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Wilhelm Nuesser <wilhelm.nuesser@sap.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: clarification about redhat and vm
Message-ID: <20020118200700.A21279@athlon.random>
In-Reply-To: <E16RFE9-00042W-00@the-village.bc.nu> <3C485169.7070005@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C485169.7070005@sap.com>; from wilhelm.nuesser@sap.com on Fri, Jan 18, 2002 at 05:46:33PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 05:46:33PM +0100, Wilhelm Nuesser wrote:
> Alan Cox wrote:
> 
> >>"If redhat doesn't use the -aa VM " was a short form of "if redhat
> >>cannot see the goodness of all the bugfixing work that happened between
> >>the 2.4.9 VM and any current branch 2.4, and so if they keep shipping
> >>2.4.9 VM as the best one for DBMS and critical VM apps like the SAP
> >>benchmark".
> >>
> >
> >The RH VM is totally unrelated to the crap in 2.4.9 vanilla. The SAP comment
> >begs a question. 2.4.10 seems to have problems remembering to actually 
> >do fsync()'s. How much of your SAP benchmark is from fsync's that dont
> >happen ? Do you get the same values with 2.4.18-aa ?
> >
> Well, basically we checked the thing many times with quite different 
> kernels.
> Our current tests - which show exactly the same results as 
> 2.4.[10,14,15] - run
> on the new "official" SuSE kernel 2.4.16.  Again, we  observe a 
> performance increase
> in high swap situations of about  a factor of ten compared to 2.4.[7,9].
>  
> IMO, this shows that errors like fsync etc. are _not_ responsible for 
> the improved
> performance.

and I assume you were using either ext2 or reiserfs anyways, so the
fsync problem never affected you since the first place (also with older
kernels) I believe.

Andrea
