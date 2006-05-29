Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWE2INR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWE2INR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 04:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWE2INR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 04:13:17 -0400
Received: from gw.openss7.com ([142.179.199.224]:5571 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750753AbWE2INR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 04:13:17 -0400
Date: Mon, 29 May 2006 02:13:15 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Chava Leviatan <chavale@actcom.net.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet driver module compilation  (8139too)
Message-ID: <20060529021315.B23539@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Chava Leviatan <chavale@actcom.net.il>,
	linux-kernel@vger.kernel.org
References: <003101c682ff$1b7c7350$c400a8c0@Chavalaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <003101c682ff$1b7c7350$c400a8c0@Chavalaptop>; from chavale@actcom.net.il on Mon, May 29, 2006 at 11:05:58AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chava,

On Mon, 29 May 2006, Chava Leviatan wrote:
> I then tried to manually install it (insmod) and was promp with unresolved
> external. I found out that
> those unresolved belong to mii.o which was not loaded during the boot
> process.

Did you reboot the machine?  Did you do depmod -ae?

Which symbols?  What did the error message say exactly...  What is the
output of depmod -ae with the module installed?

--brian
