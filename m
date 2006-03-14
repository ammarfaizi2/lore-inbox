Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWCNIiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWCNIiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWCNIiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:38:22 -0500
Received: from mail.cs.umu.se ([130.239.40.25]:2268 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1751796AbWCNIiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:38:21 -0500
Date: Tue, 14 Mar 2006 09:38:12 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: CIJOML <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dmesg is not showing whole boot list
Message-ID: <20060314083812.GA27338@brainysmurf.cs.umu.se>
References: <200603140901.27746.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603140901.27746.cijoml@volny.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 09:01:27AM +0100, CIJOML wrote:
> Hello,
> 
> maybe this si a wrong list to ask, bug after boot, dmesg shows that few lines 
> at the beginning are missing.
> 
> Is there any option I can increase to get full dmesg?

Try increasing CONFIG_LOG_BUF_SHIFT and recompile. That's likely the
source of your problem.



	Peter Hagervall

