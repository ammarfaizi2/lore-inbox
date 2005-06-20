Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVFUEox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVFUEox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVFTW66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:58:58 -0400
Received: from smtp04.auna.com ([62.81.186.14]:33703 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S261287AbVFTWfz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:35:55 -0400
Date: Mon, 20 Jun 2005 22:35:46 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-mm1
To: linux-kernel@vger.kernel.org
References: <1119267521l.17554l.1l@werewolf.able.es>
	<42B6F0AA.2060200@pobox.com>
In-Reply-To: <42B6F0AA.2060200@pobox.com> (from jgarzik@pobox.com on Mon Jun
	20 18:36:58 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1119306946l.1344l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.212.68] Login:jamagallon@able.es Fecha:Tue, 21 Jun 2005 00:35:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.20, Jeff Garzik wrote:
> J.A. Magallon wrote:
> > On 06.20, Andrew Morton wrote:
> > 
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
> >>
> >>
> >>- Someone broke /proc/device-tree on ppc64.  It's being looked into.
> >>
> >>- Nothing particularly special here - various fixes and updates.
> >>
> > 
> > 
> > I had this in my kernel, compiled from lkml ans supposed to fix some brakage
> > realted to slab management in libata. Is still needed ?
> 
> It's a patch with bugs, that needs to be fixed.  You can't call 
> scsi_eh_abort_cmds() without an abort handler, that won't accomplish too 
> much.
> 

Thanks, dropped till any news appear...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam1 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


