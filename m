Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932860AbWF1RI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbWF1RI2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWF1RI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:08:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932838AbWF1RI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:08:26 -0400
Date: Wed, 28 Jun 2006 18:08:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@namei.org>
Cc: ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SELinux/MIPS: Add security hooks to mips-mt {get,set}affinity
Message-ID: <20060628170811.GA7162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@namei.org>, ralf@linux-mips.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0606280934080.12338@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606280934080.12338@d.namei>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 09:36:46AM -0400, James Morris wrote:
> From: David Quigley <dpquigl@tycho.nsa.gov>
> 
> This patch adds LSM hooks into the setaffinity and getaffinity functions 
> for the mips architecture to enable security modules to control these 
> operations between tasks with different security attributes. This 
> implementation uses the existing task_setscheduler and task_getscheduler 
> LSM hooks.

I'm still watiting for an explanation how those syscalls made it in without
review, and even worse in an arch specific directory..

