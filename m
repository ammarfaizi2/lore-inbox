Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTH0HDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 03:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbTH0HDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 03:03:54 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:20918 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263185AbTH0HDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 03:03:53 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 27 Aug 2003 09:03:51 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org, tejun@aratech.co.kr
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-Id: <20030827090351.51a0fc31.skraw@ithnet.com>
In-Reply-To: <20030827064301.GF150921@niksula.cs.hut.fi>
References: <20030729073948.GD204266@niksula.cs.hut.fi>
	<20030730071321.GV150921@niksula.cs.hut.fi>
	<Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva>
	<20030730181003.GC204962@niksula.cs.hut.fi>
	<20030827064301.GF150921@niksula.cs.hut.fi>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 09:43:02 +0300
Ville Herva <vherva@niksula.hut.fi> wrote:

> On Wed, Jul 30, 2003 at 09:10:03PM +0300, you [Ville Herva] wrote:
> [...]
>   - HW: Intel 815EEA2LU mobo, i815, Celeron Tualatin 1.3GHz. Adaptec 2940,
>     9GB Seagate, HP C1537A tapedrive (not used), IBM-DTLA-305030 ide disk.
>   - The aic7xxx driver has been acting up in past: crashes on boot and 
>     sometimes at runtime too. I don't know if this is at all related to the
>     lock ups.
>   - Kernels tried: 2.4.22-pre8/gcc-2.96-85, 2.4.21-jam1/2.4.21-jam1, 
>     2.4.21-jam1/gcc-3.2.1-2, 2.4.20pre7 -- all hang.
> 
> Perhaps this is related to the "Race condition in 2.4 tasklet handling
> (cli() broken?)" problem TeJun Huh and Stephan von Krawczynski have been
> discussing?

This is no SMP box, is it? If it is no SMP is it probably unrelated.

Regards,
Stephan
