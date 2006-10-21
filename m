Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWJUEaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWJUEaT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 00:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWJUEaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 00:30:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751695AbWJUEaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 00:30:17 -0400
Date: Fri, 20 Oct 2006 21:29:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: 2.6.19-rc2 ipw2200 breakage with wpa_supplicant
Message-Id: <20061020212958.8156fa86.akpm@osdl.org>
In-Reply-To: <45399521.30502@shaw.ca>
References: <45399093.6090306@shaw.ca>
	<45399521.30502@shaw.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 21:33:53 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

> Robert Hancock wrote:
> > Something changed between 2.6.18-mm1 and 2.6.19-rc2 to cause my laptop's 
> > ipw2200 to be unable to associate with the access point using 
> > NetworkManager and wpa_supplicant. I keep seeing this kind of thing over 
> > and over in the wpa_supplicant output:
> 
> It looks like the bad patch is this one. Reverting it makes it work 
> again. Either there's a bug in here or it's a change breaking working 
> userspace, either way, no good:
> 
> [PATCH] WE-21 for ipw2200

Please try 2.6.19-rc2-mm2, or git-wireless.patch therefrom.
