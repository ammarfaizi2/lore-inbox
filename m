Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWJENqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWJENqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWJENqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:46:00 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13952 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750916AbWJENp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:45:59 -0400
Date: Thu, 5 Oct 2006 09:45:22 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Horms <horms@verge.net.au>, Magnus Damm <magnus@valinux.co.jp>
Subject: Re: 2.6.19-rc1: kexec broken on x86_64
Message-ID: <20061005134522.GB20551@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <aec7e5c30610050328i2bf9e3b6qcacc1873231ece28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30610050328i2bf9e3b6qcacc1873231ece28@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 07:28:35PM +0900, Magnus Damm wrote:
> Kexec is broken on x86_64 under 2.6.19-rc1.
> 
> Or rather - kexec works ok under 2.6.19-rc1, but something related to
> the vmlinux format has probably changed and kexec-tools fails to load
> a vmlinux from 2.6.19-rc1.
> 
> Loading bzImage works as usual, but vmlinux does not load properly.
> 
> The kexec binary fails with the following message:
> 
> Overlapping memory segments at 0x351000
> sort_segments failed
> / #
> 

Hi Magnus,

Can you please post the readelf -l output of the vmlinux you are trying
to load. That's will give some indication if the segments are really
overlapping in vmlinux or is it some processing bug at kexec-tools part.

Thanks
Vivek
