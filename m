Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWE3LSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWE3LSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 07:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWE3LSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 07:18:09 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:55304 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932262AbWE3LSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 07:18:07 -0400
Message-ID: <447C29CC.3070208@shadowen.org>
Date: Tue, 30 May 2006 12:17:32 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: rc5-git1 and later fail to boot on x86_64
References: <4479BC92.1090900@mbligh.org>
In-Reply-To: <4479BC92.1090900@mbligh.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> plain -rc5 seems fine. Double checking this isn't a machine issue, but
> it seems to boot the older kernels just fine.
> 
> good boot is here: http://test.kernel.org/abat/33283/debug/console.log
> for comparison

This seems to be a machine install issue.  It appears that the image on
/dev/sda1 thinks its on /dev/sdb1 which it is not which is now relevant
to the automation tools.  How this happened is lost in the mists of time
sadly.

I have fixed up the install and the reruns I have done seem ok.

-apw
