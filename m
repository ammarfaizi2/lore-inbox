Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTKRNjL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTKRNjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:39:11 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:2827 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262719AbTKRNjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:39:02 -0500
Date: Tue, 18 Nov 2003 13:39:01 +0000
From: John Levon <levon@movementarian.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HOWTO build modules in 2.6.0 ...
Message-ID: <20031118133901.GA64922@compsoc.man.ac.uk>
References: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl> <20031117203336.GA1714@mars.ravnborg.org> <20031117235927.GA31611@compsoc.man.ac.uk> <20031118055007.GC1008@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118055007.GC1008@mars.ravnborg.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AM64L-000MXI-Ov*cAUByYkYQzw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 06:50:07AM +0100, Sam Ravnborg wrote:

> > This requires a kernel source tree empty of built files though, so it's
> > really not a great solution ...
> 
> Correct - but why keep kernel trees around full of build files, when
> there is a proper solution to keep them out of the src.

Because people *will* have build trees that are in the source directory.
You're effectively requiring everybody to rebuild their kernel using
some new syntax the first time they want to compile an external module.

External modules were compilable fine (if somewhat clumsily) in 2.4
without any special setup; it's a pity that 2.6 regresses in this given
how superior the build system is in every other way.

> It can be avoided, but that required too much surgery in various
> makefiles and include statements. So that part is 2.7 material.

Would allowing non-O= builds to work again be 2.7 too ? It worked up
until very recently.

regards
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
