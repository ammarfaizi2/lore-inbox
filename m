Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTEPOIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 10:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTEPOIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 10:08:10 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:38052 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264447AbTEPOIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 10:08:09 -0400
Date: Fri, 16 May 2003 16:20:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Vojtech Pavlik <vojtech@suse.cz>, alan@lxorguk.ukuu.org.uk,
       marcelo@conectiva.com.br, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix support for SiS5581/5582/5596 IDE
Message-ID: <20030516162047.A20248@ucw.cz>
References: <20030516160222.A19746@ucw.cz> <3EC4F1FD.4010603@inet6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EC4F1FD.4010603@inet6.fr>; from Lionel.Bouton@inet6.fr on Fri, May 16, 2003 at 04:13:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 04:13:17PM +0200, Lionel Bouton wrote:

> >The last patch for SiS96* also added support for SiS5581, SiS5582 and
> >SiS5596. However, the PCI IDs for these three chips were incorrect by
> >mistake (cut and paste problem). This patch, on top of the previous one
> >fixes it, and thus adds proper support for these old chips.
> 
> Thanks for the work.
> I've yet to read carefully each change (will do this week-end), but I 
> agree on the principles.

Great. And thanks for veryfing the patch.

> The only thing that disturbed me was the removal of the DEBUG code (as 
> it often helped me find out bugs and understand new chips' behavior) but 
> I think it's best for me to maintain a patch which adds this code in the 
> very rare cases where it can be usefull.
 
I sort of expected that when I was removing it. ;) Debugging code comes
very handy when one runs into problems, but clutters up the source in
all other cases. So the final decision to keep it or have a separate
debug patch is of course in your hands. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
