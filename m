Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268620AbRGZSD1>; Thu, 26 Jul 2001 14:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268623AbRGZSDU>; Thu, 26 Jul 2001 14:03:20 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24204 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S268617AbRGZSDC>;
	Thu, 26 Jul 2001 14:03:02 -0400
Message-ID: <3B605B79.C41AED53@mandrakesoft.com>
Date: Thu, 26 Jul 2001 14:03:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness.
In-Reply-To: <200107261746.VAA31697@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

kuznet@ms2.inr.ac.ru wrote:
> > after netif_rx.
> 
> But why not to do just local_bh_disable(); netif_rx(); local_bh_enable()?
> Is this not right?

that's fine, and was one of the suggested solutions during the earlier
discussion of Andrea's fix.

-- 
Jeff Garzik      | "Mind if I drive?" -Sam
Building 1024    | "Not if you don't mind me clawing at the dash
MandrakeSoft     |  and shrieking like a cheerleader." -Max
