Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310366AbSCPNxZ>; Sat, 16 Mar 2002 08:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310367AbSCPNxP>; Sat, 16 Mar 2002 08:53:15 -0500
Received: from imladris.infradead.org ([194.205.184.45]:15120 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S310366AbSCPNxF>;
	Sat, 16 Mar 2002 08:53:05 -0500
Date: Sat, 16 Mar 2002 13:52:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Keith Owens <kaos@ocs.com.au>, Paul Mackerras <paulus@samba.org>,
        Balbir Singh <balbir_soni@yahoo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nice values for kernel modules
Message-ID: <20020316135247.A31434@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>,
	Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
	Keith Owens <kaos@ocs.com.au>, Paul Mackerras <paulus@samba.org>,
	Balbir Singh <balbir_soni@yahoo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <16358.1016282075@ocs3.intra.ocs.com.au> <Pine.LNX.4.33.0203161300300.1089-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0203161300300.1089-100000@einstein.homenet>; from tigran@aivazian.fsnet.co.uk on Sat, Mar 16, 2002 at 01:04:16PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 01:04:16PM +0000, Tigran Aivazian wrote:
> There are lots of good reasons why it has been exported, e.g. ability to
> replace some system calls while leaving overall Linux personality (i.e.
> without switching to an ABI emulation).

No, that never was a good reason and has been removed by Arjan and me
in current Linux-ABI versions.

I'm all for removing it, too.
 
> Also, ability to call those system calls from a module which are not
> exported individually.

If syscalls are supposed to be used by modules they should be exported
and have proper prototypes.
