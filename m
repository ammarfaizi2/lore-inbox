Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSHaWyU>; Sat, 31 Aug 2002 18:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSHaWyU>; Sat, 31 Aug 2002 18:54:20 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:26870
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318047AbSHaWyU>; Sat, 31 Aug 2002 18:54:20 -0400
Subject: Re: [patch 2.4.19] reboot on out-of-file handles
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020831225135.GH721@gallifrey>
References: <20020831201638.GG721@gallifrey>
	<1030826468.3582.25.camel@irongate.swansea.linux.org.uk> 
	<20020831225135.GH721@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 31 Aug 2002 23:58:55 +0100
Message-Id: <1030834735.3490.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-31 at 23:51, Dr. David Alan Gilbert wrote:
> > You can already do this reliably in user space as part of your watchdog
> > daemon processing.
> 
> Ah - good idea.
> The only thing that doesn't do (which my patch doesn't do much of), is
> log the state of the system at failure - I'd really like to know what
> ate all the filehandles.

If your daemon keeps a few open handles to reuse and the log file it can
maybe do that when it spots the problem occurs and isnt bumping the
watchdog

