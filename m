Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVATNNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVATNNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 08:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVATNNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 08:13:15 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12698 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262141AbVATNNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 08:13:09 -0500
Date: Thu, 20 Jan 2005 14:13:02 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Matthias Andree <matthias.andree@gmx.de>, samel@mail.cz,
       linux-kernel@vger.kernel.org
Subject: Re: BK-kernel-tools/shortlog update
Message-ID: <20050120131302.GB14539@merlin.emma.line.org>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, samel@mail.cz,
	linux-kernel@vger.kernel.org
References: <20050120092758.85EFE77991@merlin.emma.line.org> <20050120125132.GC3170@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120125132.GC3170@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk schrieb am 2005-01-20:

> On Thu, Jan 20, 2005 at 10:27:58AM +0100, Matthias Andree wrote:
> >...
> > @@ -481,6 +482,7 @@
> >...
> >  'bunk:fs.tum.de' => 'Adrian Bunk',
> >  'bunk:stusta.de' => 'Adrian Bunk',
> > +'bunk:stutsa.de' => 'Adrian Bunk',
> >...
> 
> Where did you find this?
> This is a typo and not a valid email address.

Thanks for reviewing and asking.

Generally, it need not be a valid address to be listed in shortlog.

OTOH, we only _need_ it listed if it was used as ($BK_USER,$BK_HOST)
tuple. I have no hints this was the case and will remove the address for
the next release.

Place of discovery:

# ChangeSet
#   2004/12/27 11:33:56-08:00 sri@us.ibm.com 
#   [SCTP] Code cleanup: remove unused code and make needlessly global code static
#
#   Signed-off-by: Adrian Bunk <bunk@stutsa.de>
#   Signed-off-by: Sridhar Samudrala <sri@us.ibm.com>
#
<http://www.kernel.org/pub/linux/kernel/v2.4/testing/cset/cset-sri@us.ibm.com%7CChangeSet%7C20041227193356%7C21934.txt>

I also reviewed an inquiry about kaos:sgi.o, which I
found used as typoed BK_USER/BK_HOST commit author
<http://kambing.ui.edu/kernel-linux/v2.6/snapshots/old/patch-2.6.7-rc2-bk7.log>
- and that address I cannot remove as it would result in the typoed
address appearing in the logs rather than author's name.

Should, some day, Signed-off-by have precedence over the changeset
author, we might reconsider this.

I have committed the change to
bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools already.

-- 
Matthias Andree
