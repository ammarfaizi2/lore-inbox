Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUFPW1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUFPW1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUFPW1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:27:45 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:49424 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264153AbUFPW1m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:27:42 -0400
Date: Thu, 17 Jun 2004 00:30:35 +0200
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AT Keyboard (was: Helge Hafting vs. make menuconfig help)
Message-ID: <20040616223035.GA7932@hh.idb.hist.no>
References: <20040615140206.A6153@beton.cybernet.src> <20040615141039.GF20632@lug-owl.de> <20040615142040.B6241@beton.cybernet.src> <20040615144127.GG20632@lug-owl.de> <20040615172129.F6843@beton.cybernet.src> <20040615173210.GM20632@lug-owl.de> <20040615174651.A6965@beton.cybernet.src> <20040615183700.GA13866@hh.idb.hist.no> <20040615195903.A7813@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040615195903.A7813@beton.cybernet.src>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 07:59:03PM +0000, Karel Kulhavý wrote:
> > 4. From there, the key is propagated through tty and
> >    console and ends up in your application.  This application
> >    might be X, which passes the key onto some program using X.
> 
> I am insterested in the 4. itself.
> 
> What's the console?
The console is the text interface you see when not running 
X (the graphical user interface).
 
> I get a feeling that it's where kernel writes it's debug
> messages but sometimes 
Yes, the console is also used for this.

> else I get a feeling it's the text output of the
> machine at all.
> 
You can also have text output in an xterm, thats not the console.
Or even on real terminals connected to serial ports.

> And what are the ttys? And does the key go first into console and then tty,
> or the other way?

TTY = TeleTYpe interface.  The machine may have quite a few different
text interfaces, one of them is special and is the console.

Helge Hafting
