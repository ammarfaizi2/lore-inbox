Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVJFOlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVJFOlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVJFOlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:41:09 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:22485 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751046AbVJFOlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:41:08 -0400
Message-Id: <200510061440.j96Eee4e004352@laptop11.inf.utfsm.cl>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Valdis.Kletnieks@vt.edu, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Message from Helge Hafting <helge.hafting@aitel.hist.no> 
   of "Thu, 06 Oct 2005 11:31:59 +0200." <4344EF0F.90402@aitel.hist.no> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 06 Oct 2005 10:40:40 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 06 Oct 2005 10:40:41 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> Valdis.Kletnieks@vt.edu wrote:
> >The part that you managed to miss is that this is MAC - *Mandatory*
> >Access Control.  This means that the *sysadmin* gets to say "this user
> >can't look at that file" - and there's nothing(*) either the owner of the
> >file or the user can do about it.  There's no chmod or chattr or chacl
> >command that the owner can issue to let somebody else read it - that's
> >the whole *point* of MAC.
> >
> >(*) Well.. almost nothing.  The owner *may* be able to copy the contents
> >of the file to another file that the other user is allowed to read.  On the
> >other hand, the ability to do this would generally indicate a buggy policy....

> Seems to me there is no use taking away the owners ability to chmod,
> precisely because the owner always can get around that. (Unless
> the owner doesn't even have the right to read his own file.)

No. The point is that a (correct, complete) policy will prevent the user
from copying the contents to a file with less protection, by any means. No,
I did emphatically /not/ try to imply this is easy to set up (or use).

[...]

> Company policy may of course forbid the user to bring a camera, just as it
> might forbid the user to do "chmod o+r" on important files.  I am not
> sure that we need the OS to try to enforce such things.

If you don't trust your (typically fat-fingered) users and sysadmins...
Besides, the point behind the targeted policy in Red Hat/Fedora is to
forbid certain daemons to do nasty stuff. It is an additional protection
against misconfiguration or processes taken over by crackers.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
