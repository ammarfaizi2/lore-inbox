Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUI2OcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUI2OcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUI2O3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:29:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57054 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268511AbUI2O11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:27:27 -0400
Date: Wed, 29 Sep 2004 15:27:23 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Core scsi layer crashes in 2.6.8.1
Message-ID: <20040929142723.GG16153@parcelfarce.linux.theplanet.co.uk>
References: <1096401785.13936.5.camel@localhost.localdomain> <1096467125.2028.11.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096467125.2028.11.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 10:11:59AM -0400, James Bottomley wrote:
> I have a theory that we should be taking a device reference before
> waking up the error handler, otherwise host removal can race with error
> handling.

That would certainly mesh with what's happening with Anton's sick ppc64
box ...

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
