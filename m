Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269924AbUJGXWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269924AbUJGXWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269909AbUJGXGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:06:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:42403 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269897AbUJGXGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:06:07 -0400
Subject: Re: Power parents
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0410071444220.650-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0410071444220.650-100000@ida.rowland.org>
Content-Type: text/plain
Message-Id: <1097189945.16223.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 08:59:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 04:46, Alan Stern wrote:
> Ben:
> 
> Pavel Machek suggested you were a good person to ask this question.
> 
> I see that the power tree agrees pretty much with the device tree, but
> there is the possibility of having a different parent pointer.  However
> the device_pm_set_parent() routine isn't called anywhere in the kernel.  
> Does that mean it can be eliminated, making the two trees identical?

Currently the trees are identical yes. I may still want to "insert"
special nodes in the Power tree though...

Ben.


