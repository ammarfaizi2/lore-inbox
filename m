Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313442AbSDLIJ7>; Fri, 12 Apr 2002 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313447AbSDLIJz>; Fri, 12 Apr 2002 04:09:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:35799 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313442AbSDLIJc>;
	Fri, 12 Apr 2002 04:09:32 -0400
Date: Fri, 12 Apr 2002 10:09:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
Message-ID: <20020412100929.B17963@ucw.cz>
In-Reply-To: <20020411170910.GS612@gallifrey> <20020411191339.B15435@ucw.cz> <20020411174941.GC17962@antefacto.com> <20020411.195921.730560311.rene.rebe@gmx.net> <20020411210606.A15783@ucw.cz> <3CB68FA6.F2DACB93@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 09:41:26AM +0200, Helge Hafting wrote:
> Vojtech Pavlik wrote:
> 
> > > It IS the kernel's fault, because only one VT can be active. The
> > > kernel VT stuff needs to be redesigned to hadle multiple VT at the
> > > same time ...
> > 
> > Yes and no. You shouldn't need VTs to run Xservers at all.
> 
> Still a kernel problem, what if all the users want to run
> vgacon/fbcon instead of X?  One VT per physical interface
> is what we need, rather than "per machine".

Yes. James Simmons has this work almost done.

-- 
Vojtech Pavlik
SuSE Labs
