Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRDEV5R>; Thu, 5 Apr 2001 17:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129126AbRDEV5H>; Thu, 5 Apr 2001 17:57:07 -0400
Received: from 13dyn139.delft.casema.net ([212.64.76.139]:37904 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129112AbRDEV47>; Thu, 5 Apr 2001 17:56:59 -0400
Message-Id: <200104052156.XAA02219@cave.bitwizard.nl>
Subject: Re: Arch specific/multiple Configure.help files?
In-Reply-To: <20010405214136.X18749@arthur.ubicom.tudelft.nl> from Erik Mouw
 at "Apr 5, 2001 09:41:36 pm"
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Date: Thu, 5 Apr 2001 23:56:13 +0200 (MEST)
CC: Johan Adolfsson <johan.adolfsson@axis.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Thu, Apr 05, 2001 at 07:28:33PM +0200, Johan Adolfsson wrote:
> > Would it be a good idea to have support for multiple Configure.help
> > files in the config system?
> > The main advantage would be that arch specific settings could
> > have an arch specific help file as well.
> 
> I don't see why this would be an advantage. IMHO Documentation belongs
> in the Documentation tree and configuration documentation belongs in
> Configure.help. You almost never read that file yourself, only the
> various kernel configure tools read it, and tools don't have a problem
> with large files. It's better to have the documentation at a single
> point, not scattered around in the kernel tree.

Well, the configure help is now "scattered around": The configuration
options are in the "configure.in" files, and hte docs for them are
somewhere else, even if it's in one large file.

I'm not sure if Larry's CML2 has the help for the options near the
options or not, but that's how I'd like it to be if I were designing
the thing from scratch. (a bit like emacs' functions: there too, you
give the help text near the definition of a functions!)

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
