Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUJ1O7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUJ1O7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUJ1O7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:59:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32649 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261680AbUJ1O7j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:59:39 -0400
Message-ID: <4181094D.7020800@pobox.com>
Date: Thu, 28 Oct 2004 10:59:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: [PATCH] Fix e100 suspend/resume w/ 2.6.10-rc1 and above (due
 to pci_save_state change)
References: <20041028025536.5d9b1067.akpm@osdl.org> <41810066.5000705@pobox.com> <20041028142956.GA9400@kroah.com>
In-Reply-To: <20041028142956.GA9400@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> Huh?  How did changing the pci_save_state() api change anything?  I
> didn't change the pci core any, just made it easier to not have to
> specify the storage location of the memory to save everything off on.

That could have been accomplished by moving the saved-config data 
storage into struct pci_dev, but not changing pci_save_state() prototype...

	Jeff


