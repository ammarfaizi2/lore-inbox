Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTHSIeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 04:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTHSIeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 04:34:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65298 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264030AbTHSIeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 04:34:17 -0400
Date: Tue, 19 Aug 2003 09:34:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Narayan Desai <desai@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: weird pcmcia problem
Message-ID: <20030819093414.A12052@flint.arm.linux.org.uk>
Mail-Followup-To: Narayan Desai <desai@mcs.anl.gov>,
	linux-kernel@vger.kernel.org
References: <87u18efpsc.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87u18efpsc.fsf@mcs.anl.gov>; from desai@mcs.anl.gov on Mon, Aug 18, 2003 at 07:34:59PM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 07:34:59PM -0500, Narayan Desai wrote:
> cs: warning: no high memory space available!
> cs: unable to map card memory!
> cs: unable to map card memory!

Hmm, this looks suspicious.  For some reason, we can't find any memory
resources to map the CIS, so we can't identify the card type, which
means we'll probably identify the card as a memory card.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

