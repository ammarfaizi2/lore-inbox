Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbVJ3AzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbVJ3AzI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbVJ3AzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:55:08 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:30700 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932723AbVJ3AzF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:55:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MmHtyDqMe0MLIUu4cj/rhi+NEMt4bSFXyaaOeiOQc4HL79hW3gZzrideT3HScQSjYjgpxV9RduutJcDX99aWabxr5Yq4vcnsdS6SJw2VH3H4/Kgb22sKbquiMvLfThkdpbrQu/v7mp+zlksxXTjZRoTLjvV8fTZQjRFgLU9cB54=
Message-ID: <12c511ca0510291755j3548c61em73d5f9e20e7d1404@mail.gmail.com>
Date: Sat, 29 Oct 2005 17:55:05 -0700
From: Tony Luck <tony.luck@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patches] 2.6.x libata updates
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510291526040.3348@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051029182228.GA14495@havoc.gtf.org>
	 <20051029121454.5d27aecb.akpm@osdl.org> <4363CB60.2000201@pobox.com>
	 <Pine.LNX.4.64.0510291229330.3348@g5.osdl.org>
	 <20051029152157.01369c35.akpm@osdl.org>
	 <Pine.LNX.4.64.0510291526040.3348@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps the script that creates the -git1 etc. nightly snapshots
could peek at how many commits were included since the
previous snapshot ... if it is above some threshhold, then it
could run "git bisect" to create a -git0.5 (recursing if needed
to make -git0.25 etc.)

-Tony
