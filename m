Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVJMSbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVJMSbC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVJMSbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:31:02 -0400
Received: from starnet.skynet.com.pl ([213.25.173.230]:9619 "EHLO
	skynet.skynet.com.pl") by vger.kernel.org with ESMTP
	id S932155AbVJMSbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:31:00 -0400
Date: Thu, 13 Oct 2005 20:30:38 +0200
From: Marcin Owsiany <marcin@owsiany.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI "asking for cache data failed"
Message-ID: <20051013183038.GA13293@kufelek>
References: <20051013104536.GA10525@kufelek> <1129208154.18635.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129208154.18635.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-Scanner: exiscan *1EQ7qh-0005lO-00*N8Vb166SbGo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 01:55:54PM +0100, Alan Cox wrote:
> On Iau, 2005-10-13 at 12:45 +0200, Marcin Owsiany wrote:
> > I'm wondering about the following messages, which appeared when I upgraded from
> > 2.4 to 2.6:
> > 
> > | sda: asking for cache data failed
> > | sda: assuming drive cache: write through
> > 
> > (a larger log snippet below)
> 
[...]
> It should be ok providing the raid card itself is
> handling the consistency correctly but check with your card vendor.

Does that depend on the card only, or rather on the driver?
(megaraid_mbox in this case) If the latter, then maybe someone familiar
with its code can tell if the driver is OK in this regard?

thanks,

Marcin
-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 1024D/60F41216  FE67 DA2D 0ACA FC5E 3F75  D6F6 3A0D 8AA0 60F4 1216
 
"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
