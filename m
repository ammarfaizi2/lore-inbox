Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVCMVsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVCMVsb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 16:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVCMVsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 16:48:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:3979 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261382AbVCMVsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 16:48:30 -0500
Subject: Re: 2.6.11-mm3: machine check on sleep, PowerBook5.4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <6uzmx75xiv.fsf@zork.zork.net>
References: <20050312034222.12a264c4.akpm@osdl.org>
	 <6upsy37o0v.fsf@zork.zork.net> <1110717016.5787.143.camel@gaston>
	 <1110717351.5787.146.camel@gaston>  <6uzmx75xiv.fsf@zork.zork.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 08:47:31 +1100
Message-Id: <1110750451.5787.152.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-13 at 16:19 +0000, Sean Neakums wrote:
> Both patches give me a successful sleep, although I had to alter the
> second to not #if 0 core99_ata100_enable -- there's another call to
> that function in pmac_feature.c's set_initial_features().
> 
> I will try to gather some power numbers.

Thanks.

Ben.


