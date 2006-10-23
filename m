Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWJWUga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWJWUga (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWJWUga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:36:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:738 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751076AbWJWUg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:36:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=byDJGDq1iXuUcoVkTfRPt1vqzVTs0ip6dzRq4IT7hGAEkzaCNd8V4fKqHnRw/HeCb7Mds2gX333hAR3n4NL+ZZk7kAtSvUdWfACszQoPiaT6Ard7TfFyKxuENrcDHWl5f9IWiQR5TxEPP2DiesBDGZHHB19c3G3nOojcph/iOnI=
Message-ID: <806dafc20610231336s58d64ad8s3bf47b922601ca38@mail.gmail.com>
Date: Mon, 23 Oct 2006 16:36:27 -0400
From: "Christopher \"Monty\" Montgomery" <xiphmont@gmail.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.19-rc1-mm1 - locks when using "dd bs=1M" from card reader
Cc: "Helge Hafting" <helge.hafting@aitel.hist.no>,
       "Paolo Ornati" <ornati@fastwebnet.it>,
       "Kernel development list" <linux-kernel@vger.kernel.org>,
       "USB development list" <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0610201133110.7060-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4538B689.2020909@aitel.hist.no>
	 <Pine.LNX.4.44L0.0610201133110.7060-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> At this point it's beyond me.  Monty will have to take it from here.

I will look more closely at what might have changed there.  Despite
the code refactoring (and a hand-resolved patch collision at that
point) the async disable handling *should* have been functionally
unchanged from 2.6.18.  I will revisit that closely.

Has it actually been demonstrated that this does not crash 2.6.18
(pre-my-patches) kernels?  If it crashes earlier, that doesn't mean
I'm uninterested in fixing it, I just want to know.  I don't think
that had been explicitly answered earlier in the thread.

Monty
