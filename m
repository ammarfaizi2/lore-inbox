Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUL1VPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUL1VPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 16:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbUL1VPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 16:15:37 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:51770 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261258AbUL1VPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 16:15:32 -0500
Date: Tue, 28 Dec 2004 22:17:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [patch 0/3] kallsyms: Add gate page and all symbols support
Message-ID: <20041228211700.GA21591@mars.ravnborg.org>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <28912.1101613127@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28912.1101613127@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 02:38:47PM +1100, Keith Owens wrote:
> Three patches with the overall aim of improving kernel backtraces using
> kallsyms.
> 
> 1 Clean up the special casing of in_gate_area().
> 
> 2 Add in_gate_area_no_task() for use from places where no task is valid.
> 
> 3 Treat the gate page as part of the kernel.  Honour CONFIG_KALLSYMS_ALL.
> 

Applied all three patches - thanks.

	Sam
