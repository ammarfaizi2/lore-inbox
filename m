Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVFOMCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVFOMCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 08:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFOMCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 08:02:40 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:37798 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261396AbVFOMCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 08:02:38 -0400
Date: Wed, 15 Jun 2005 14:02:37 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Gr?goire Favre <gregoire.favre@gmail.com>, dino@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050615120237.GB19645@janus>
References: <1118081857.5045.49.camel@mulgrave> <20050607085710.GB9230@gmail.com> <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com> <1118695847.5079.41.camel@mulgrave> <20050613214208.GA7471@janus> <1118703593.5079.56.camel@mulgrave> <20050614214226.GA15560@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614214226.GA15560@janus>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 11:42:26PM +0200, Frank van Maarseveen wrote:
> 
> So, I'm kind of stuck with a very slow driver initialization. I think it
> takes much longer than the 30 seconds visible in the logfile, at least
> that's the impression I have (I'll use a stopwatch next time).

The -rc6 aic7 driver needs just over 7 minutes to recover from this tape
unit. In -rc3 this was 80 seconds. -rc2 had no problem.

I don't really need this old tape unit and I don't [re-]boot that often
so it is not a problem for me. Anyway, if something needs to be tested
then mail me a patch (for stock rc6) and I'll try it.

-- 
Frank
