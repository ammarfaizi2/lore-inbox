Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWBZXCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWBZXCj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWBZXCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:02:39 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36022 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751425AbWBZXCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:02:36 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1140994427.3982.11.camel@localhost.localdomain>
References: <1140917787.24141.78.camel@mindpipe>
	 <1140945232.2934.0.camel@laptopd505.fenrus.org>
	 <1140982513.24141.118.camel@mindpipe>
	 <1140988293.3982.8.camel@localhost.localdomain>
	 <1140989489.24141.159.camel@mindpipe>
	 <1140994427.3982.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 18:02:31 -0500
Message-Id: <1140994951.24141.204.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 09:53 +1100, Benjamin Herrenschmidt wrote:
> Well... as soon as a 3d window appears, the server starts switching
> all the time. there might be some spin loop in there remaining... 

But if the only lock taken in the radeon driver is the BKL, the
SCHED_NORMAL X server should not be able to delay a SCHED_FIFO process
right?

Lee

