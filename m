Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270673AbUJULQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270673AbUJULQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 07:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270582AbUJULNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 07:13:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36832 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270673AbUJULLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 07:11:44 -0400
Date: Thu, 21 Oct 2004 12:11:37 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       SCSI <linux-scsi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] SCSI: Replace semaphore with completion
Message-ID: <20041021111137.GB16153@parcelfarce.linux.theplanet.co.uk>
References: <1098300699.20821.68.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098300699.20821.68.camel@thomas>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 09:31:39PM +0200, Thomas Gleixner wrote:
> 
> Use completion instead of semaphore

OK, I've taken this into my tree.  It'll be part of the 2.1.18m release.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
