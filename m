Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVCDL5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVCDL5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbVCDLzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:55:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:62171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262860AbVCDL2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:28:54 -0500
Date: Fri, 4 Mar 2005 03:28:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, jgarzik@pobox.com, torvalds@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304032820.7e3cb06c.akpm@osdl.org>
In-Reply-To: <1109933804.26799.11.camel@localhost.localdomain>
References: <42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
	<20050303151752.00527ae7.akpm@osdl.org>
	<1109894511.21781.73.camel@localhost.localdomain>
	<20050303182820.46bd07a5.akpm@osdl.org>
	<1109933804.26799.11.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
>  Almost without exception maintainers will forget the backport (there are
>  some notable exceptions). Almost without exception maintainers will not
>  be aware that their backport fix clashes with another fix because that
>  isn't their concern.
> 
>  Linus will try and sneak stuff in that is security but not mentioned
>  which has to be dug out (because the bad guys read the patches too).
> 
>  And finally Linus throws the occasional gem into the backporting mix
>  because he will (rightly) do the long term fix that rearranges a lot of
>  code when the .x.y patch needs to be the ugly band aid.
> 
>  So for example Linus will happily changed remap_vm_area to fix a
>  security bug by changing the API entirely and making it do some other
>  things. Or in the case of the exec bug he did a fix that defaulted any
>  missed fixes to unsafe. Fine for upstream where the goal is cleanness,
>  bad for .x.y because the arch people hadn't caught up and did have
>  remaining holes.
> 
>  You also have to review the dependancy tree for a backport and what was
>  tested - so I skipped the NFS df fix as one example as it had never been
>  tested standalone only on a pile of other NFS fixes.

I think you're assuming that 2.6.x.y will have larger scope than is intended.

