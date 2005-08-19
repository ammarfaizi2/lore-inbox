Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVHSO7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVHSO7e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 10:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVHSO7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 10:59:34 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:51332 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964966AbVHSO7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 10:59:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nkqRYVZqtCEe1MFdaatQ626NXak5A7Vh0QC+ThZ+f2yzz7nPPQusMcC/iswnleEhRkhZrMGwb6oKtaFJIUMfJnRFeZ/0KnQYQSKT22nvXx6y5PdYRyLlS0lnAtx1qCBtf7lBh/kUjiRr4V2mPBybIcjHtXJpDPE+HOHCG6Y3DWM=
Message-ID: <dff375270508190759613dcd6@mail.gmail.com>
Date: Fri, 19 Aug 2005 14:59:30 +0000
From: kristina clair <kclair@gmail.com>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050819085823.B4075975@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050518175925.GA22738@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
	 <428BA8E4.2040108@wildbrain.com>
	 <Pine.LNX.4.58.0505191537560.7094@chaos.egr.duke.edu>
	 <Pine.LNX.4.58.0505191650580.7094@chaos.egr.duke.edu>
	 <Pine.LNX.4.58.0505191740550.7094@chaos.egr.duke.edu>
	 <Pine.LNX.4.58.0505191746470.7094@chaos.egr.duke.edu>
	 <428D0D1E.9070607@wildbrain.com>
	 <dff3752705081811498984f5@mail.gmail.com>
	 <20050819085823.B4075975@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, it doesn't.

Is that something that should help?  Now that the error has occurred
once, it occurred again within 24 hours.

Thanks,
Kristina

On 8/18/05, Nathan Scott <nathans@sgi.com> wrote:
> On Thu, Aug 18, 2005 at 06:49:05PM +0000, kristina clair wrote:
> > I've just come across this oops.  We're running gentoo with a 2.6.11
> > kernel, xfs + nfs + lvm (+hardware raid).
> 
> Check whether your kernel has this fix included:
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4120db47198d21d8cd3b2cdbbe1ea6118a50bcd4
> 
> cheers.
> 
> --
> Nathan
> 


-- 
kristina clair,
latest stable version: 2.9
latest beta version: 3.0-pre
