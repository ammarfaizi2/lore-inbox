Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWAFCEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWAFCEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWAFCEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:04:06 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:44198 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751097AbWAFCEF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:04:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XJrygxy7sw0R7q05AIe2Ee/D8sIQsijDqw7mQw+corqDRs70PzsSswG0W4a/CMnR4GXtz6KrwR2qeep1apRDi2rQQwcIAa/7qGCFdDBRSgpeedI0W+PjvyqRT1lmDSWsTj654vnqZGR+Z7AZPScZgIi1EVw/sX5xUgwsM8oVIDs=
Message-ID: <86802c440601051804n23017262v9afe2d0c8643fb49@mail.gmail.com>
Date: Thu, 5 Jan 2006 18:04:04 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: x86_64: calibrate_delay_direct and apic id lift for BSP
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linuxbios@openbios.org
In-Reply-To: <200510282053.07608.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <86802c440510281142i11771f25o3f6667869b4d614e@mail.gmail.com>
	 <200510282053.07608.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Andi Kleen <ak@suse.de> wrote:
>
> They change when interrupt 0 fires. So it's probably misrouted
> or similar.

the problem fixed, on the AMD 8111 based MB, if lift the bsp apic id,
the LinuxBIOS need to set the dest processor apic id in the 8111 io
apic reg setup for IRQ0.

Thanks.

YH
