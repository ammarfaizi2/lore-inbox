Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290815AbSBFVNn>; Wed, 6 Feb 2002 16:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290812AbSBFVNe>; Wed, 6 Feb 2002 16:13:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19987 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290810AbSBFVN3>;
	Wed, 6 Feb 2002 16:13:29 -0500
Message-ID: <3C619C71.5D2A710F@mandrakesoft.com>
Date: Wed, 06 Feb 2002 16:13:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Applying 2.5.4-pre1 patch
In-Reply-To: <3C6119E2.2060504@wanadoo.fr> <3C619586.92EAED50@mandrakesoft.com> <3C619927.2020601@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> 
> Jeff Garzik wrote:
> > Pierre Rousselet wrote:
> >
> >>Patching drivers/char/gameport with /dev/null doesn't work for me. What
> >>is the trick ?
> >>
> >
> > /dev/null indicates a new, or a removed, file.
> 
> 'patch -p0 < patch' is confused by this : "sure you want to delete this
> file ?"

Linus's patches should be applied with -p1.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
