Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261409AbSJUOqr>; Mon, 21 Oct 2002 10:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbSJUOqr>; Mon, 21 Oct 2002 10:46:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26413 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261409AbSJUOqp>; Mon, 21 Oct 2002 10:46:45 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kexec for 2.5.44 (Who do I send this to?)
References: <Pine.LNX.3.96.1021019151759.29078I-100000@gatekeeper.tmr.com>
	<1035203491.27259.71.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Oct 2002 08:51:08 -0600
In-Reply-To: <1035203491.27259.71.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1fzuzvo9v.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> I will start picking stuff up now I'm back and catching up on email
> (I've been away for a week). I'm not however interested in kexec or ltt
> or a lot of the other large stuff so don't bother resending me that kind
> of thing.
> 
> I really want to collect up bug fixes/compile fixes/driver updates and
> small but ready to merge stuff like the console updates if James Simmons
> is paying attention.

I am half insulted.  kexec is about as ready to merge as it comes...
But I do admit the code to safely position the new kernel safely in
memory safely is a little large.  

And there is not a lot of point in widespread testing of kexec until
the drivers get fixed to actually do something when device_shutdown
runs.  As drivers that don't shutdown properly are a fairly serious
issue. 

If you are interested I can break out my reboot time hardware bug
fixes, and send you those.

Eric
