Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWE3Ktp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWE3Ktp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWE3Ktp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:49:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24081 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932175AbWE3Ktp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:49:45 -0400
Date: Tue, 30 May 2006 12:49:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make sysctl obligatory except under CONFIG_EMBEDDED
Message-ID: <20060530104943.GF3955@stusta.de>
References: <200605292334.k4TNYgKg029556@terminus.zytor.com> <E1Fksi6-0003Tm-00@calista.eckenfels.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Fksi6-0003Tm-00@calista.eckenfels.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 03:07:50AM +0200, Bernd Eckenfels wrote:
> H. Peter Anvin <hpa@zytor.com> wrote:
> > This patch makes sysctl non-optional unless EMBEDDED is set.  There
> > are a number of interfaces exposed via sysctl, enough that it has to
> > be considered core kernel functionality at this point.
> 
> is this to help the user to configure the kernel or is it to remove
> complexity (you just introduced some)

Obviously the first.

I don't see how his patch affects complexity in any way. The patch is 
both small and obvious (and CONFIG_SYSCTL=n is still a valid and 
supported configuration).

> Gruss
> Bernd

cu
Adrian

BTW: Dropping people from the Cc is considered impolite on this list.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

