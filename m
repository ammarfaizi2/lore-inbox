Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264245AbSIQPDa>; Tue, 17 Sep 2002 11:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264247AbSIQPDa>; Tue, 17 Sep 2002 11:03:30 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:33778 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264245AbSIQPD3>; Tue, 17 Sep 2002 11:03:29 -0400
Date: Tue, 17 Sep 2002 11:08:28 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Kirk Reiser <kirk@braille.uwo.ca>, Skip Ford <skip.ford@verizon.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.35 undefined reference to `wait_task_inactive'
Message-ID: <20020917110828.D23555@redhat.com>
References: <200209160644.g8G6iEvo006691@pool-141-150-241-241.delv.east.verizon.net> <x7sn08k7r0.fsf@speech.braille.uwo.ca> <3D87422B.3080300@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D87422B.3080300@drugphish.ch>; from ratz@drugphish.ch on Tue, Sep 17, 2002 at 04:54:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 04:54:35PM +0200, Roberto Nibali wrote:
> BTW, ACPI needs a few tunings too to be able to compile the stuff as 
> modules, but I'm sure that also here it's not the right thing to do, I 
> simply did a quick hack to have a running and bootable 2.5.35 kernel:
...
> +#ifdef MODULE
>           ACPI_MODULE_NAME    ("hwgpe")
> +#endif

Btw, why not put the #ifdef in the header file that defines 
ACPI_MODULE_NAME(x) instead of littering more #ifdefs around code?

		-ben
