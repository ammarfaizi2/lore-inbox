Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311829AbSDDWq6>; Thu, 4 Apr 2002 17:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311834AbSDDWqp>; Thu, 4 Apr 2002 17:46:45 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:32780 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311829AbSDDWqc>; Thu, 4 Apr 2002 17:46:32 -0500
Date: Thu, 4 Apr 2002 18:41:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>, Andre Hedrick <andre@linux-ide.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5
In-Reply-To: <Pine.NEB.4.44.0204042146520.7845-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.21.0204041840370.10636-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andre? 

On Thu, 4 Apr 2002, Adrian Bunk wrote:

> Hi Marcelo,
> 
> Configure.help contains the help text below that sounds more like a
> comment to a patch than a helpful help message for a user of a stable
> kernel:
> 
> +CONFIG_IDE_TASKFILE_IO
> +  This is the "Jewel" of the patch.  It will go away and become the new
> +  driver core.  Since all the chipsets/host side hardware deal w/ their
> +  exceptions in "their local code" currently, adoption of a
> +  standardized data-transport is the only logical solution.
> +  Additionally we packetize the requests and gain rapid performance and
> +  a reduction in system latency.  Additionally by using a memory struct
> +  for the commands we can redirect to a MMIO host hardware in the next
> +  generation of controllers, specifically second generation Ultra133
> +  and Serial ATA.
> +
> +  Since this is a major transition, it was deemed necessary to make the
> +  driver paths buildable in separtate models.  Therefore if using this
> +  option fails for your arch then we need to address the needs for that
> +  arch.
> +
> +  If you want to test this functionality, say Y here.
> 
> Could anyone provide a more useful help text?
> 
> TIA
> Adrian
> 
> 


