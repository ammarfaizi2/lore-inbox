Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVIFVQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVIFVQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVIFVQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:16:27 -0400
Received: from mail.cs.umn.edu ([128.101.33.102]:3024 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S1750960AbVIFVQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:16:26 -0400
Date: Tue, 6 Sep 2005 16:16:21 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Anton Blanchard <anton@samba.org>, Linda Xie <lxiep@us.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Santiago Leon <santil@us.ibm.com>
Subject: Re: [PATCH] IBM VSCSI Client: handle large scatter/gather lists
Message-ID: <20050906211621.GA14057@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Anton Blanchard <anton@samba.org>, Linda Xie <lxiep@us.ibm.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Santiago Leon <santil@us.ibm.com>
References: <42C2D85E.5010306@us.ibm.com> <20050906074943.GS6945@krispykreme> <1126016005.5012.1.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126016005.5012.1.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 09:13:25AM -0500, James Bottomley wrote:
> On Tue, 2005-09-06 at 17:49 +1000, Anton Blanchard wrote:
> > Any chance we could get this into 2.6.14? I just tested it on current
> > git and as expected the number of sg elements increased. Testing a dd
> > from a virtual disk with clustering disabled (to avoid physical merging
> > effects) shows:
> 
> Yes ... but according to my records it wasn't acked by the
> maintainer ... does he agree?

Yes.  Acking Linda's patches has been on my todo list for month..sorry
for the lag.

-- 
Dave Boutcher
