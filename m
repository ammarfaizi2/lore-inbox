Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUFQUpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUFQUpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUFQUpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:45:44 -0400
Received: from vsmtp1b.tin.it ([212.216.176.141]:41167 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S262927AbUFQUpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:45:42 -0400
Message-ID: <40D20449.5000107@stanchina.net>
Date: Thu, 17 Jun 2004 22:51:21 +0200
From: Flavio Stanchina <flavio@stanchina.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: "Adam J. Richter" <adam@yggdrasil.com>, hch@lst.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, Michael Poole <mdpoole@troilus.org>
Subject: Re: more files with licenses that aren't GPL-compatible
References: <200406180629.i5I6Ttn04674@freya.yggdrasil.com> <87n032xk82.fsf@sanosuke.troilus.org> <20040617100930.A9108@adam> <96BD7BAE-C092-11D8-8574-000393ACC76E@mac.com>
In-Reply-To: <96BD7BAE-C092-11D8-8574-000393ACC76E@mac.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> If someone distributes _on_their_own_ (site, CDs, whatever) copies
> of Linux with their copyrighted code in it, or contributes copyrighted
> code _that_they_own_, they are giving someone a license to use
> against them.  That is actually one of the difficulties SCO is facing
> right now in court; _they_ distributed copies of Linux _including_ any
> code that they may claim is copyrighted.  Since they have the right to
> license such code, any license that appears to be associated with it
> when they distribute it becomes valid even if it was not before.  If you
> distribute a copy of Linux under the GPL that contains code you
> claim is violating your copyright, then I don't believe you have a leg
> to stand on, legally.

Your argument applies to the SCO case because their code (if there is 
any, which nobody but SCO still believes is the case) did *not* have a 
license attached to it that didn't allow modification, redistribution or 
whatever else the GPL requires; otherwise they wouldn't have trouble 
demonstrating which code it is they're talking about. So any sane person 
would understand that they knowingly released it under the GPL: if 
they'll try to argue that they didn't know the kernel was covered by the 
GPL, I don't think the judge will go for much less than capital 
punishment when he stops laughing.

In this case, if I followed the discussion correctly, there are files 
and binary blobs in the kernel whose license explicitly disallows some 
of the freedoms the GPL grants. So they *have* to get out of the kernel 
proper *now*, period. There is no other choice, legally.

Once those files and stuff are out of the kernel, we can think of a 
solution that works from both a technical and a legal perspective, such 
as loading firmware from external files (which users will have to 
download themselves from vendors' sites -- we can't distribute them in 
any form if they don't change the license). Modules under a non-GPL 
license are a different can of worms: many people believe they are 
violating the GPL even if they remain outside of the kernel proper 
because they are obviously a derivative work of the kernel. So far AFAIK 
nobody sued NVidia, ATI or anyone else for distributing non-GPL modules, 
but they can _not_ stay in the kernel. I wonder how and why they were 
accepted in the first place.

-- 
Ciao, Flavio

