Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbUCOSGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbUCOSE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:04:59 -0500
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:51392 "EHLO
	garfield") by vger.kernel.org with ESMTP id S262655AbUCOSDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:03:37 -0500
Message-ID: <4055F027.2070906@free.fr>
Date: Mon, 15 Mar 2004 19:04:23 +0100
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20040312 Debian/1.4.1-0jds1
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Fabian Fenaut <fabian.fenaut@free.fr>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm1 and -mm2: include/linux/version.h missing (vanilla
 ok)
References: <S262583AbUCOOfF/20040315143505Z+146@vger.kernel.org> <20040315174148.GA2163@mars.ravnborg.org>
In-Reply-To: <20040315174148.GA2163@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> On Mon, Mar 15, 2004 at 03:35:01PM +0100, Fabian Fenaut wrote:
> 
>> Why is there no include/linux/version.h after having compiled -mm1
>>  and -mm2 ? Compilation of kernel is fine, but because of this, my
>>  nvidia modules won't compile.
>> 
>> As said in the subject, 2.6.4 vanilla is ok, version.h is here 
>> after compilation.
>> 
>> I use debian woody, and I type
>> 
>> make-kpkg --append-to-version -ff --revision 1 binary-arch 
>> make-kpkg --append-to-version -ff --revision 1 modules_image
> 
> I dunno make-kpkg, but 'make clean' became a bit more effective in 
> mm1. So now 'make clean' deletes version.h - maybe that's your 
> problem?

I didn't run neither make-clean nor make-kpkg clean, and however,
version.h is not here, even just after the compilation of the kernel.

And, to compile my modules successfully, I copied version.h from vanilla
to /usr/src/2.6.4-mm2/include/linux (and modified it the correct way).
Then I compiled my modules, and after that, my hand-made version.h is
still here, so make-kpkg doesn't delete anything.

=> version.h is _never_ created.

Thank you for your help.

--
Fabian

