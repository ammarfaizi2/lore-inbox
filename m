Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282418AbRLRNO4>; Tue, 18 Dec 2001 08:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRLRNOg>; Tue, 18 Dec 2001 08:14:36 -0500
Received: from ns.suse.de ([213.95.15.193]:52238 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282418AbRLRNOd>;
	Tue, 18 Dec 2001 08:14:33 -0500
Date: Tue, 18 Dec 2001 14:14:32 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Christian Thalinger <e9625286@student.tuwien.ac.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cpuid on SMP
In-Reply-To: <1008675995.13737.2.camel@twisti.home.at>
Message-ID: <Pine.LNX.4.33.0112181413510.29077-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec 2001, Christian Thalinger wrote:

> Just wanted to try Dave Jones' x86info. It complained about missing
> /dev/cpu/0/... So i inserted cpuid and started it again. Now it
> complains about /dev/cpu/1/...
> And there is no /dev/cpu/1/.

mkdir /dev/cpu/1
mknod /dev/cpu/1/cpuid c 203 1
mknod /dev/cpu/1/msr c 202 1

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

