Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSFTWDw>; Thu, 20 Jun 2002 18:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSFTWDv>; Thu, 20 Jun 2002 18:03:51 -0400
Received: from ns.suse.de ([213.95.15.193]:48652 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315779AbSFTWDt>;
	Thu, 20 Jun 2002 18:03:49 -0400
Date: Fri, 21 Jun 2002 00:03:50 +0200
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rvandijk@science.uva.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
Message-ID: <20020621000350.S29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rvandijk@science.uva.nl>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619205136.GA18903@suse.de> <200206192133.g5JLXH814796@mail.science.uva.nl> <20020619234035.R29373@suse.de> <200206202138.g5KLcsO04303@mail.science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206202138.g5KLcsO04303@mail.science.uva.nl>; from rvandijk@science.uva.nl on Thu, Jun 20, 2002 at 11:42:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 11:42:03PM +0200, Rudmer van Dijk wrote:

 > > 2. Can you disable agpgart, and try again. I'm fairly certain this
 > >    is the cause, but just in case..
 > 
 > just checked 2 but no improvement, also checked without drm again no 
 > solution...

Well, that's sort of good in a way.. it means the agpgart changes aren't
to blame. 8-)

As for your crash in exit.c, I'm puzzled by that one. Are you using 
preempt ? if so, does disabling that fix it ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
