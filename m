Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263617AbTCUNpa>; Fri, 21 Mar 2003 08:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263619AbTCUNpa>; Fri, 21 Mar 2003 08:45:30 -0500
Received: from angband.namesys.com ([212.16.7.85]:62604 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S263617AbTCUNp3>; Fri, 21 Mar 2003 08:45:29 -0500
Date: Fri, 21 Mar 2003 16:56:28 +0300
From: Oleg Drokin <green@namesys.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kswapd oops in 2.4.20 SMP+NFS
Message-ID: <20030321165628.K17440@namesys.com>
References: <1048170204.5161.11.camel@calculon> <20030321112834.A17330@namesys.com> <1048240247.9345.19.camel@fortknox> <20030321130402.C17440@namesys.com> <1048243299.9338.23.camel@fortknox> <20030321135841.D17440@namesys.com> <1048245614.9338.41.camel@fortknox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048245614.9338.41.camel@fortknox>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 21, 2003 at 12:20:14PM +0100, Soeren Sonnenburg wrote:


> I just checked the logs... It seems that the oops occurs 24 seconds
> after the backup script was started (which is run hourly). 
> This script first mounts the nfs share, then looks for modified files
> and tar's them over, then umounts the share.
> So it is probably the umount of that nfs partion.

Well, then I think NFS people may be interested in that oops.
Resend it to them please and state that this is most likely from NFS.

Thank you.

Bye,
    Oleg
