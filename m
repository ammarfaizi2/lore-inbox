Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTDRR6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTDRR6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:58:32 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:10732 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S263178AbTDRR6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:58:31 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Organization: Ozzmosis Corp.
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [patch] VMnet/VMware workstation 4.0
Date: Fri, 18 Apr 2003 15:10:36 -0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <D79F957BFD@vcnet.vc.cvut.cz>
In-Reply-To: <D79F957BFD@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304181510.36372.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, there are distributions and a lot of "end-users" around using devfs. 
About 2.2.x: I think only putting #ifdef CONFIG_DEVFS_FS before defining the 
'static devfs_handle_t devfs_handle' can fix the problem. Can you test that?

The patches I sent are also available on 
http://cscience.org/~lucasvr/patches/vmnet-only-3.2.patch and 
http://cscience.org/~lucasvr/patches/vmnet-only-4.0.patch .

Lucas


On Thursday 17 April 2003 15:12, Petr Vandrovec wrote:
> On 17 Apr 03 at 13:48, Lucas Correia Villa Real wrote:
> > Is there a "correct" place at vmware.com to send these patches? I tryied
> > sending it to feature-request@vmware.com, but I got no response from
> > them.
> >
> > Anyway, below follows the patch providing support to devfs on the vmnet
> > driver for vmware workstation 4.0.
>
> You can send them to me if you do not trust feature-request...
>
> Proble with your patch is that it does not look like that it will
> build on 2.2.x without complaints, but I can fix that. More important
> question to me is: do people really use devfs?
>
> And if change will not make into next WS release, I can always distribute
> it from my site.
>                                                 Petr Vandrovec

