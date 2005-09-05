Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVIEPrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVIEPrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVIEPrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:47:00 -0400
Received: from smtp.istop.com ([66.11.167.126]:60638 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932192AbVIEPq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:46:59 -0400
From: Daniel Phillips <phillips@istop.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: GFS, what's remaining
Date: Mon, 5 Sep 2005 11:49:49 -0400
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509030157.31581.phillips@istop.com> <20050905141432.GF5498@marowsky-bree.de>
In-Reply-To: <20050905141432.GF5498@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051149.49929.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 10:14, Lars Marowsky-Bree wrote:
> On 2005-09-03T01:57:31, Daniel Phillips <phillips@istop.com> wrote:
> > The only current users of dlms are cluster filesystems.  There are zero
> > users of the userspace dlm api.
>
> That is incorrect...

Application users Lars, sorry if I did not make that clear.  The issue is 
whether we need to export an all-singing-all-dancing dlm api from kernel to 
userspace today, or whether we can afford to take the necessary time to get 
it right while application writers take their time to have a good think about 
whether they even need it.

> ...and you're contradicting yourself here:

How so?  Above talks about dlm, below talks about cluster membership.

> > What does have to be resolved is a common API for node management.  It is
> > not just cluster filesystems and their lock managers that have to
> > interface to node management.  Below the filesystem layer, cluster block
> > devices and cluster volume management need to be coordinated by the same
> > system, and above the filesystem layer, applications also need to be
> > hooked into it. This work is, in a word, incomplete.

Regards,

Daniel
