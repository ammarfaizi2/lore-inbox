Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWEPSQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWEPSQD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWEPSQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:16:03 -0400
Received: from colin.muc.de ([193.149.48.1]:11012 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932480AbWEPSQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:16:01 -0400
Date: 16 May 2006 20:15:59 +0200
Date: Tue, 16 May 2006 20:15:59 +0200
From: Andi Kleen <ak@muc.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] Kdump i386 nmi event notification fix
Message-ID: <20060516181559.GA16113@muc.de>
References: <20060515174835.GA28981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515174835.GA28981@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 01:48:35PM -0400, Vivek Goyal wrote:
> 
> 
> o After a crash we should wait for NMI IPI event and not for external NMI
>   or NMI watchdog tick.

The two patches don't apply anymore after Don's big NMI rework.
Can you forward port and retest/resend please?  
-Andi
