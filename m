Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269247AbUIYGcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269247AbUIYGcM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 02:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUIYGcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 02:32:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58592 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269247AbUIYGcL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 02:32:11 -0400
Date: Sat, 25 Sep 2004 07:32:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 4/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups and a bugfix
Message-ID: <20040925063210.GP23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 05:13:20PM +0100, Anton Altaparmakov wrote:
> This is patch 4/10 in the series.  It contains the following ChangeSet:
> 
> <aia21@cantab.net> (04/09/23 1.1951)
>    NTFS: Change '\0' and L'\0' to simply 0 as per advice from Linus Torvalds.

Take one more step and replace cpu_to_le16(0) with 0...
