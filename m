Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBTRFj>; Tue, 20 Feb 2001 12:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbRBTRF3>; Tue, 20 Feb 2001 12:05:29 -0500
Received: from nas13-208.wms.club-internet.fr ([213.44.40.208]:44527 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S129144AbRBTRFQ>;
	Tue, 20 Feb 2001 12:05:16 -0500
Message-Id: <200102201704.SAA13364@microsoft.com>
Subject: Re: Is this the ultimate stack-smash fix?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>
Cc: Andreas Bombe <andreas.bombe@munich.netsurf.de>,
        Eric "W." Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A929DF2.CDA7F949@sympatico.ca>
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca>    
	<m1lmr98c5t.fsf@frodo.biederman.org> <3A8ADA30.2936D3B1@sympatico.ca>    
	<m1hf1w8qea.fsf@frodo.biederman.org> <3A8BF5ED.1C12435A@colorfullife.com>   
	 <m1k86s6imn.fsf@frodo.biederman.org> <20010217084330.A17398@cadcamlab.org> 
	  <m1y9v4382r.fsf@frodo.biederman.org>  <20010220021012.A1481@storm.local>  
	<200102200909.KAA12190@microsoft.com>  <3A929DF2.CDA7F949@sympatico.ca>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution (0.8 - Preview Release)
Date: 20 Feb 2001 18:04:12 +0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20 Feb 2001 11:40:18 -0500, Jeremy Jackson a écrit :
> Xavier Bestel wrote:
> 
> > Le 20 Feb 2001 02:10:12 +0100, Andreas Bombe a écrit :
> > >
> > > An array is a word that contains the address of the first element.
> >
> > No. Exercise 3: compile and run this:
> > file a.c:
> > char array[] = "I'm really an array";
> >
> > file b.c:
> > extern char* array;
> > main() { printf("array = %s\n", array); }
> >
> 
> try file b.c
> extern char array;
> main() { printf("array= %s\n", &array); }

So ?


