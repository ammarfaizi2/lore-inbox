Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269165AbUIHRJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269165AbUIHRJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 13:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269167AbUIHRJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 13:09:25 -0400
Received: from netblock-66-159-231-38.dslextreme.com ([66.159.231.38]:28556
	"EHLO mail.cavein.org") by vger.kernel.org with ESMTP
	id S269165AbUIHRJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 13:09:21 -0400
Date: Wed, 8 Sep 2004 10:11:06 -0700 (PDT)
From: Richard A Nelson <cowboy@debian.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
In-Reply-To: <20040908020402.3823a658.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0409081009590.7419@hygvzn-guhyr.pnirva.bet>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
 <20040908020402.3823a658.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Andrew Morton wrote:

> Richard A Nelson <cowboy@debian.org> wrote:
> >
> >  I've received a few of these already - always during *very* heavy disk
> >  activity. After the Oops, the disk becomes strangely idle :), and a reboot
> >  is required.
> >
> >   Unable to handle kernel paging request at virtual address 6b6b6b93
> > ...
> >   EIP: 0060:[__journal_clean_checkpoint_list+199/240]    Not tainted VLI
>
> This might have been caused by a fishy latency-reduction patch.  I today
> dropped that patch so could you please test next -mm and let me know?
>
> Alternativety, revert ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/broken-out/journal_clean_checkpoint_list-latency-fix.patch

Reverted and building now, will reboot and test asap
-- 
Rick Nelson
<Addi> Alter.net seems to have replaced one of its router with a zucchini.
