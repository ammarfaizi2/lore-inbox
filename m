Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030702AbWJLHaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030702AbWJLHaS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030699AbWJLHaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:30:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47837 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030692AbWJLHaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:30:15 -0400
Subject: Re: [patch 17/67] Fix longstanding load balancing bug in the
	scheduler
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061011210449.GR16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
	 <20061011210449.GR16627@kroah.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 12 Oct 2006 09:30:12 +0200
Message-Id: <1160638212.3000.409.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 14:04 -0700, Greg KH wrote:
> plain text document attachment
> (fix-longstanding-load-balancing-bug-in-the-scheduler.patch)
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Christoph Lameter <christoph@sgi.com>
> 
> The scheduler will stop load balancing if the most busy processor contains
> processes pinned via processor affinity.


a scheduler change sounds awefully risky for a -stable release,
especially if the head patch with it isn't fully released yet (so very
limited tested).....

as such I'd yank this from this stable release and leave it out until at
least 2.6.19 has been out for a while without complaints about
scheduling.



