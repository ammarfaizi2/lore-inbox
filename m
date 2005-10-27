Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVJ0TDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVJ0TDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 15:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVJ0TDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 15:03:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:24038 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932078AbVJ0TDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 15:03:38 -0400
Subject: Re: CONFIG_X86_INTEL_USERCOPY and MCYRIXIII?
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051027165126.GB9419@redhat.com>
References: <1130391254.19492.11.camel@mindpipe>
	 <20051027165126.GB9419@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 14:35:16 -0400
Message-Id: <1130438117.19492.51.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 12:51 -0400, Dave Jones wrote:
> On Thu, Oct 27, 2005 at 01:34:14AM -0400, Lee Revell wrote:
>  > I tried it on my EPIA board and it works.  Is there a good reason it's
>  > not allowed by Kconfig?
>  > 
>  > config X86_INTEL_USERCOPY
>  >         bool
>  >         depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII
>  > || M586MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON
>  >         default y
> 
> Do you have numbers that show its worthwhile ?
> The last time I tried it, it wasn't.

No, I figured I'd ask before benchmarking it.  Thanks for the info.

Lee

