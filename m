Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWAIO2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWAIO2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWAIO2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:28:16 -0500
Received: from mail1.kontent.de ([81.88.34.36]:62350 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932285AbWAIO2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:28:15 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Mon, 9 Jan 2006 15:28:18 +0100
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <5t06S-7nB-15@gated-at.bofh.it> <5t5JU-7Sn-11@gated-at.bofh.it> <43C270B2.4050305@shaw.ca>
In-Reply-To: <43C270B2.4050305@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091528.19285.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Januar 2006 15:18 schrieb Robert Hancock:
> Yaroslav Rastrigin wrote:
> > Well, I could find more or less reasonable explanation of this behaviour - different VM policies of two OSes and 
> > strangely strong and persistent belief "Free RAM is a wasted RAM" among kernel devs. Free RAM is not a wasted RAM, its a memory waiting to be used ! 
> > Whenever it is needed by apps I'm launching or working with. 
> 
> There is no different VM policy here, Windows behaves quite similarly. 
> It does not leave memory around unused, it uses it for disk cache.

That doesn't mean that the rate of eviction is the same.
Is it possible that read-ahead is not aggressive enough?

	Regards
		Oliver
