Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVCDFg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVCDFg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVCDFg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:36:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:49053 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261480AbVCDFfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 00:35:31 -0500
Date: Thu, 3 Mar 2005 21:34:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, torvalds@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303213454.50e2f584.akpm@osdl.org>
In-Reply-To: <4227CE58.6020607@pobox.com>
References: <42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
	<20050303151752.00527ae7.akpm@osdl.org>
	<1109894511.21781.73.camel@localhost.localdomain>
	<20050303182820.46bd07a5.akpm@osdl.org>
	<4227CE58.6020607@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
>  > Am I right?  All we're proposing here is a tree which has small fixups for
>  > reasonably serious problems.  Almost without exception it would consist of
>  > backports.
> 
>  "thru-ports":  commit to linux-2.6.x.y and get Linus to pull.

This means that for patches which didn't come through -mm, their first
exposure in a public tree will be when they pop up in our "most stable"
tree.  That's backwards.

However it should be manageable, as long as linux-release is constrained to
obviously-correct and its-no-more-broken-now-than-it-used-to-be patches. 
