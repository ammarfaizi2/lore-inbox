Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbRFZTrW>; Tue, 26 Jun 2001 15:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbRFZTrN>; Tue, 26 Jun 2001 15:47:13 -0400
Received: from [64.64.109.142] ([64.64.109.142]:43783 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S265101AbRFZTrB>; Tue, 26 Jun 2001 15:47:01 -0400
Message-ID: <3B38E686.D2252E31@didntduck.org>
Date: Tue, 26 Jun 2001 15:46:14 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: iscollect@millrose.com
CC: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx kernel driver; ATTN Mr. Justin T. Gibbs
In-Reply-To: <3B38C4D2.EB2A8944@mycompany.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mihai Gata wrote:
> 
> Trying to use an AIC7890 SCSI controller with kernel 2.4.5 I have
> the problem reported into the attached log files.  Same problems with
> kernel 2.4.3.  Kernels below 2.4 doesn't even see it.  In MS Windows 95
> it works without any problems.  I used 3 variations of SCSI controllers
> built upon AIC7890, so I don't think all 3 are bad.  One was made for
> Compaq and two for Dell.  The AIC7890 is around since a while so that's
> the problem with Linux in corp. computing.  It's great but cannot use
> it.

Make certain that the SCSI bus is properly terminated.  Most of the SCSI
errors reported here are a result of bad termination.

--

				Brian Gerst
