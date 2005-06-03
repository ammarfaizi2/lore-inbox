Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVFCOTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVFCOTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 10:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVFCOTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 10:19:04 -0400
Received: from animx.eu.org ([216.98.75.249]:949 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261280AbVFCOTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 10:19:02 -0400
Date: Fri, 3 Jun 2005 10:15:04 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Tomko <tomko@avantwave.com>, linux-kernel@vger.kernel.org
Subject: Re: question why need open /dev/console in init() when starting kernel
Message-ID: <20050603141504.GA14641@animx.eu.org>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	Tomko <tomko@avantwave.com>, linux-kernel@vger.kernel.org
References: <42A00065.9060201@avantwave.com> <Pine.LNX.4.61.0506030629170.11487@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506030629170.11487@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> For error messages (as well as it's the law)! Init needs a terminal.
> Init is the 'father' of all future tasks and they need a default terminal
> too.

Is it at all possible that if /dev/console does not exist that the kernel
can mknod it?

Would the code to do this be larger than 2 entries in a cpio archive (one
for /dev directory and one for /dev/console char dev)?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
