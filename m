Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291893AbSBNVNN>; Thu, 14 Feb 2002 16:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291908AbSBNVNE>; Thu, 14 Feb 2002 16:13:04 -0500
Received: from fsgi03.fnal.gov ([131.225.68.48]:22356 "EHLO fsgi03.fnal.gov")
	by vger.kernel.org with ESMTP id <S291893AbSBNVMw>;
	Thu, 14 Feb 2002 16:12:52 -0500
Date: Thu, 14 Feb 2002 15:12:29 -0600
From: Alexander Moibenko <moibenko@fnal.gov>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: fsync delays for a long time.
In-Reply-To: <E16bT7y-00017B-00@the-village.bc.nu>
Message-ID: <Pine.SGI.4.31.0202141510530.3270649-100000@fsgi03.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Alan Cox wrote:

> > > fsync on a very large file is very slow on the 2.2 kernels
> >
> > This could very well be due to request allocation starvation.
> > fsync is sleeping in __get_request_wait() while bonnie keeps
> > on stealing all the requests.
>
> That may amplify it but in the 2.2 case fsync on any sensible sized file
> is already horribly performing. It hits databases like solid quite badly
>
please elaborate on "sensible sized". In my case it is less then 20MB.
--------------------------------------------------------------------------
Alexander N. Moibenko, Integrated Systems Development, CD, Fermilab
Tel: (630)840-3937
email: moibenko@fnal.fnal.gov
--------------------------------------------------------------------------

