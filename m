Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVLGNyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVLGNyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVLGNyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:54:41 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38547 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751033AbVLGNyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:54:40 -0500
Message-Id: <200512071354.jB7Dsc7t007083@laptop11.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Matthias Andree <matthias.andree@gmx.de> 
   of "Wed, 07 Dec 2005 12:29:09 BST." <20051207112909.GA4012@merlin.emma.line.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Wed, 07 Dec 2005 10:54:38 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 07 Dec 2005 10:54:38 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:
> On Tue, 06 Dec 2005, Dmitry Torokhov wrote:
> > On 12/6/05, Matthias Andree <matthias.andree@gmx.de> wrote:
> > > QA has to happen at all levels if it is supposed to be affordable or
> > > scalable. The development process was scaled up, but QA wasn't.

> > > How about the Signed-off-by: lines? Those people who pass on the changes
> > > also pass on the bugs, and they are responsible for the code - not only
> > > license-wise, but also quality-wise. That's the latest point where
> > > regression tests MUST happen.

> > People who pass the changes can only test ones they have hardware for.
> > For the rest they can try to validate the code by reading patches but
> > have to rely on the submitter wrt to the patch actually working.

> What I'm saying is that people (maintainer) should have a selected
> number of people (users) test the patches before they are merged.

Each one gets the patches from people who tested them on their machines
(presumably), and the maintainer signs them off for code decency and (if he
has the hardware) working on his machine too. It is very hard to get much
more than that in terms of early testers. Again, one of the standard
complaints here is that very few test the -rcX kernels, and then scream
murder when the -final breaks. Now consider the case of proposed patches...

Yet, the solution is /very/ simple: Instead of complaining, set up a
machine with the hardware that particularly interests you, get on the
relevant lists, find out where the proposed patches are kept and test
them. You could even add a Signed-off-by: line to the patches you check
out. And again, "somebody should do..." won't get you anywhere, "here I
do..."  has more of a chance of success.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
