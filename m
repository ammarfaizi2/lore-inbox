Return-Path: <linux-kernel-owner+w=401wt.eu-S1754774AbXAAXYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbXAAXYI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754727AbXAAXYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:24:07 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:39333 "EHLO
	smtp151.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbXAAXYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:24:05 -0500
Message-ID: <45999872.8070207@gentoo.org>
Date: Mon, 01 Jan 2007 18:25:38 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Using _syscall3 to manipulate files in a driver
References: <9e4733910612310913v191b519fpa179bfc56f140baf@mail.gmail.com>
In-Reply-To: <9e4733910612310913v191b519fpa179bfc56f140baf@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> I have the source code for a vendor written driver that is targeted at
> 2.6.9. It includes this and then proceeds to manipulate files from the
> driver.

In future just kill the code in question, it's wrong and not needed. 
It's already mostly disabled in the code, based on my request. It is 
also not present in the community-maintained vendor driver.

Daniel
