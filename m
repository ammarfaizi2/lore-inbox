Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUJVN4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUJVN4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbUJVN4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:56:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:5581 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267535AbUJVN4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:56:50 -0400
Date: Fri, 22 Oct 2004 15:58:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: "K.R. Foley" <kr@cybsft.com>, "J.A. Magallon" <jamagallon@able.es>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm3 fails to detect aic7xxx
Message-ID: <20041022135800.GA8254@elte.hu>
References: <1097178019.24355.39.camel@localhost> <1097188963l.6408l.2l@werewolf.able.es> <41661013.9090700@cybsft.com> <41668346.6090109@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41668346.6090109@adaptec.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Luben Tuikov <luben_tuikov@adaptec.com> wrote:

> >>>backing out bk-scsi.patch seems to fix it.  I believe this worked in
> >>>2.6.9-rc3-mm2.

> >Mine doesn't without backing out those patches :) See my other post 
> >about this.
> >
> >04:05.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> >04:05.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> 
> You can see you have different chips.  It's the IDs.
> I'll come up with something shortly.

Same adapter, same problem here:

 03:04.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
 03:04.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

any patch i could try (other than backing out the whole SCSI patch)? 

	Ingo
