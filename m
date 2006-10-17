Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWJQTtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWJQTtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWJQTtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:49:14 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:33807 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751247AbWJQTtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:49:01 -0400
Message-ID: <453533AB.9020801@argo.co.il>
Date: Tue, 17 Oct 2006 21:48:59 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Ryan Richter <ryan@tau.solarneutrino.net>
CC: "Dr. David Alan Gilbert" <dave@treblig.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: DVD drive not recognized on Intel G965 (2.6.19-rc2)
References: <20061017180420.GD24789@tau.solarneutrino.net>
In-Reply-To: <20061017180420.GD24789@tau.solarneutrino.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2006 19:48:59.0330 (UTC) FILETIME=[49D8E220:01C6F225]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Richter wrote:
>
> On Sat, Oct 14, 2006 at 01:56:44PM +0100, Dr. David Alan Gilbert wrote:
> > * Ryan Richter (ryan@tau.solarneutrino.net) wrote:
> > > Hi, I have a new machine with an Intel 965G chipset.  There's a DVD
> > > drive on the IDE port that I can boot off of, but linux doesn't 
> find it.
> > >
> >
> > Hi Ryan,
> >   I suspect that the DVD is connected to a JMicron IDE coontroller not
> > to the 965 itself? I might be wrong but I'd heard fo a few 965 machines
> > like that?
> > Try turning that on in the kernel config
>
> I tried the JMicron driver, but it didn't find a controller.  This board
> has only one PATA port, and I'm pretty sure it's from the Intel
> southbridge.
>

I have a similar board.

Try adding all-generic-ide to the kernel command line, and if that 
fails, post your lspci output.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

