Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSFRGnP>; Tue, 18 Jun 2002 02:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317343AbSFRGnO>; Tue, 18 Jun 2002 02:43:14 -0400
Received: from linux.kappa.ro ([194.102.255.131]:64396 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S317342AbSFRGnN>;
	Tue, 18 Jun 2002 02:43:13 -0400
Date: Tue, 18 Jun 2002 09:45:26 +0300
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: Felipe Contreras <al593181@mail.mty.itesm.mx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird make bug in 2.5.22
Message-ID: <20020618064526.GA27319@linux.kappa.ro>
References: <20020618064056.GA2456@zion.mty.itesm.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020618064056.GA2456@zion.mty.itesm.mx>
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

139 return code means that the process that make was running
crashed with signal 11 ( 128 + 11 ) Segmentation Fault so 
perhaps you have some other kind of problems? like a faulty machine?

On Tue, Jun 18, 2002 at 01:40:56AM -0500, Felipe Contreras wrote:
> Hi,
> 
> I have this problem when running 2.5.22, make can't run itself inside a
> Makefile.
> 
> Let's say I have this Makefile:
> test:
> 	( make -v )
> 
> It fails saying this:
> ( make -v )
> make: *** [test] Error 139
> 
> I don't have any idea about what can be causing this error, might be something
> to do with reiserfs...
> 
> Any ideas?
> 
> -- 
> Felipe Contreras
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Teo
