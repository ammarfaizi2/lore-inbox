Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267168AbUFZOFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbUFZOFI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 10:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267169AbUFZOFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 10:05:08 -0400
Received: from 153.80-202-99.nextgentel.com ([80.202.99.153]:8139 "EHLO
	gspr.dyndns.org") by vger.kernel.org with ESMTP id S267168AbUFZOFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 10:05:04 -0400
From: Gard Spreemann <gspr@gspr.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Doubt
Date: Sat, 26 Jun 2004 16:05:02 +0200
User-Agent: KMail/1.6.2
References: <20040625191444.51512.qmail@web90103.mail.scd.yahoo.com>
In-Reply-To: <20040625191444.51512.qmail@web90103.mail.scd.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406261605.03347.gspr@gspr.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 June 2004 21:14, so usp wrote:
> Hi Guys,
>
> I would like to know when a compiling the kernel if a
> really need to use the comand make modules_install.
> I'm asking the question because a would like to use
> the old kernel to with the new one that a create.

Do the make modules_install. The new modules will be in a separate directory 
(/lib/modules/<version>) and will not interfere with older kernels that you 
might have.

 -- Gard
