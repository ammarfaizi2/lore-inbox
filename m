Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbTLRTDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbTLRTDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:03:07 -0500
Received: from cc15467-a.groni1.gr.home.nl ([217.120.147.78]:6710 "HELO
	boetes.org") by vger.kernel.org with SMTP id S265251AbTLRTDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:03:04 -0500
Date: Thu, 18 Dec 2003 20:03:08 +0100
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: panic with 2.6.0 and jfs which doesn't happen with test11
Message-ID: <20031218190330.GD28497@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031218140936.GA2216@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218140936.GA2216@boetes.org>
X-GPG-Key: http://www.xs4all.nl/~hanb/keys/Han_pubkey.gpg
X-GPG-Fingerprint: EB66 D194 AB3F 4C57 49EF 6795 44AE E0D8 3F38 7301
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Han Boetes wrote:
> I just compiled 2.6.0 and after booting I got a panic:
> 
> INIT: cannont execute "/etc/rc.d/rc.sysinit"
> 
> This problem doesn't occur with 2.6.0-test11 with the same config.
> 
> 
> To do some testing I booted the kernel in with `260 init=/bin/sh' and
> then tried: `ls -la /etc/fstab'
> 
> It took about two seconds to answer, printed:
> 
> -rw-r--r--    1 root     root          868 nov  2 22:58 /etc/fstab\n
> 
> and then hanged.
> 
> 
> I tried this a few times and it's really consistent.

Sorry, I was dead wrong there. This is a gcc-3.3.2 related problem:

  http://marc.theaimsgroup.com/?l=mandrake-cooker&m=107166064321438&w=2



# Han
