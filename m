Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUAEHDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 02:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265888AbUAEHDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 02:03:34 -0500
Received: from 5.86.35.65.cfl.rr.com ([65.35.86.5]:4992 "EHLO
	drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S265883AbUAEHDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 02:03:33 -0500
Date: Sun, 4 Jan 2004 16:05:07 -0500
From: Pat Erley <paterley@mail.drunkencodepoets.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 (future kernel) wish
Message-Id: <20040104160507.22f6b9da.paterley@mail.drunkencodepoets.com>
In-Reply-To: <3FEE4BD9.5000000@why.dont.jablowme.net>
References: <200312232342.17532.josh@stack.nl>
	<20031226233855.GA476@hh.idb.hist.no>
	<3FECCAF9.7070209@maine.rr.com>
	<1072507896.27022.226.camel@menion.home>
	<3FEE47F5.6090406@why.dont.jablowme.net>
	<1072581073.4042.10.camel@fur>
	<3FEE4BD9.5000000@why.dont.jablowme.net>
Organization: drunkencodepoets.com
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003 22:19:53 -0500
Jim Crilly <jim@why.dont.jablowme.net> wrote:

> >>I also believe Windows mounts any removable device 
> >>synchronously so that if you do pull it out prematurely the damage done 
> >>is limited.
> > 
> > 
> > Eww, I hope not, that would be excruciatingly slow.  It might adjust the
> > buffer writeback to be really short (even nearly immediate) but
> > synchronous I/O is a different story, and much slower.
> > 
> > 	Rob Love
> > 
> > 
> 
> Perhaps synchronous was the wrong term =) But it does atleast seem to do 
> less buffering for removable devices or I could just be fooled by 
> something else slowing it down.

check under device manager and notice that there is an option checked on USB media disks that says "SYNC"?  I'm pretty sure that's pretty much synchronous transfers I assume.

Pat Erley

(Just delt with a neuros vs mvp3 chipset problem and noticed it)
