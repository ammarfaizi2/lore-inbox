Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSDLHm4>; Fri, 12 Apr 2002 03:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSDLHmz>; Fri, 12 Apr 2002 03:42:55 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:62994 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313419AbSDLHmy>; Fri, 12 Apr 2002 03:42:54 -0400
Message-ID: <3CB68FA6.F2DACB93@aitel.hist.no>
Date: Fri, 12 Apr 2002 09:41:26 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.7-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
In-Reply-To: <20020411170910.GS612@gallifrey> <20020411191339.B15435@ucw.cz> <20020411174941.GC17962@antefacto.com> <20020411.195921.730560311.rene.rebe@gmx.net> <20020411210606.A15783@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> > It IS the kernel's fault, because only one VT can be active. The
> > kernel VT stuff needs to be redesigned to hadle multiple VT at the
> > same time ...
> 
> Yes and no. You shouldn't need VTs to run Xservers at all.

Still a kernel problem, what if all the users want to run
vgacon/fbcon instead of X?  One VT per physical interface
is what we need, rather than "per machine".

Helge Hafting
