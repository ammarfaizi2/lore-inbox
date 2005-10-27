Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVJ0Qvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVJ0Qvp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVJ0Qvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:51:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28549 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751271AbVJ0Qvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:51:44 -0400
Date: Thu, 27 Oct 2005 12:51:26 -0400
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_X86_INTEL_USERCOPY and MCYRIXIII?
Message-ID: <20051027165126.GB9419@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1130391254.19492.11.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130391254.19492.11.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 01:34:14AM -0400, Lee Revell wrote:
 > I tried it on my EPIA board and it works.  Is there a good reason it's
 > not allowed by Kconfig?
 > 
 > config X86_INTEL_USERCOPY
 >         bool
 >         depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII
 > || M586MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON
 >         default y

Do you have numbers that show its worthwhile ?
The last time I tried it, it wasn't.

		Dave

