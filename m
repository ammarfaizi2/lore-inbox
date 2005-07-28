Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVG1MWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVG1MWp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVG1MWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:22:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:56795 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261424AbVG1MVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:21:34 -0400
Date: Thu, 28 Jul 2005 17:51:40 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: dipankar das <dipankar_dd@yahoo.com>
Cc: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: core file not generated when kernel is crashed with Sysrq key
Message-ID: <20050728122140.GC4962@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050728115242.60695.qmail@web40710.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728115242.60695.qmail@web40710.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 04:52:42AM -0700, dipankar das wrote:
> Hi,
> core file is not generated when kernel is crashed with
> Sysrq key ?
> 

Do you mean that /proc/vmcore is not present once you are booted into 
capture kernel after crash? If yes, have you enabled the support for
/proc/vmcore in capture kernel (CONFIG_PROC_VMCORE)?

Thanks
Vivek
