Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVCMVys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVCMVys (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 16:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVCMVys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 16:54:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:14987 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261469AbVCMVyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 16:54:47 -0500
Subject: Re: 2.6.11-mm3: machine check on sleep, PowerBook5.4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <6usm2z5pq3.fsf@zork.zork.net>
References: <20050312034222.12a264c4.akpm@osdl.org>
	 <6upsy37o0v.fsf@zork.zork.net> <1110717016.5787.143.camel@gaston>
	 <1110717351.5787.146.camel@gaston> <6uzmx75xiv.fsf@zork.zork.net>
	 <6usm2z5pq3.fsf@zork.zork.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 08:53:54 +1100
Message-Id: <1110750834.19810.162.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-13 at 19:07 +0000, Sean Neakums wrote:
> Sean Neakums <sneakums@zork.net> writes:
> 
> > Both patches give me a successful sleep, although I had to alter the
> > second to not #if 0 core99_ata100_enable -- there's another call to
> > that function in pmac_feature.c's set_initial_features().
> >
> > I will try to gather some power numbers.
> 
> With the first patch, charge dropped by 33 over 52 minutes, 0.64/min.
> With the second patch, charge dropped by 65 over 80 minutes, 0.81/min.

Hi ! With the same initial charge ? The problem is that the drop isn't
really linear... Anyway, thanks for testing, so it would _seem_ that the
Darwin way isn't as efficient as what I did ;)

Ben.


