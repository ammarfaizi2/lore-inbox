Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVI3IgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVI3IgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 04:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVI3IgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 04:36:17 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:49131 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932571AbVI3IgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 04:36:16 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: jmerkey <jmerkey@utah-nac.org>
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
Date: Fri, 30 Sep 2005 09:36:50 +0100
User-Agent: KMail/1.8.91
Cc: Grant Coady <grant_lkml@dodo.com.au>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Nuno Silva <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0509290916450.20827@p34> <p8goj1h0a6g0oje8uijpi5r2b95l7sj8n4@4ax.com> <433C3043.6020607@utah-nac.org>
In-Reply-To: <433C3043.6020607@utah-nac.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509300936.50185.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 September 2005 19:19, jmerkey wrote:
> Grant Coady wrote:
> >On Thu, 29 Sep 2005 11:53:21 -0600, jmerkey <jmerkey@utah-nac.org> wrote:
> >>Someone needs to fix SATA drive ordering in the kernel so it matches
> >>GRUBs ordering, or perhaps GRUB needs fixing. I have run into
> >
> >                    ^^^^^^^^^^^^^^^^^^^^^^^^^
> >User-space issue?  Four of the last five drives I buy are SATA, I
> >don't see this problem 'cos I use lilo :o)
> >
> >Cheers
>
> Seems to show up on FC2/3/4 installs on Piix motherboards. The drive
> parameters reported for /dev/sda, /dev/sdb are inverted based on the
> BIOS ordering of the SATA devices. It's more a BIOS issues I think. I
> have noted that IDE doesn't change the ordering, but the current Linux
> drivers do.

It's a BIOS issue. I had problems on my MSI nForce3 mainboard because when you 
select the "bootable SATA harddrive", it swaps round the ports so that the 
one you selected is hd0, and the others follow. I couldn't fix it, so in the 
end I just installed grub on both HDs separately, then use the BIOS toggle to 
switch between them.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
