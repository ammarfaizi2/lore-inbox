Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278078AbRKMNNO>; Tue, 13 Nov 2001 08:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278770AbRKMNNC>; Tue, 13 Nov 2001 08:13:02 -0500
Received: from castle.nmd.msu.ru ([193.232.112.53]:22789 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S278078AbRKMNMz>;
	Tue, 13 Nov 2001 08:12:55 -0500
Message-ID: <20011113162017.A705@castle.nmd.msu.ru>
Date: Tue, 13 Nov 2001 16:20:17 +0300
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Robert Cantu <robert@tux.cs.ou.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
In-Reply-To: <3BF03AA9.4050205@tux.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <3BF03AA9.4050205@tux.ou.edu>; from "Robert Cantu" on Mon, Nov 12, 2001 at 03:10:01PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 03:10:01PM -0600, Robert Cantu wrote:
> 
>  pre4: 
> 	--snip--
>  - Andrey Savochkin/Andrew Morton: eepro100 config space save/restore over suspend 
> 	--snip--
> 
> My eepro100 mini-pci card on my laptop currently doesn't handle sleep/suspend very well
> for me and needs a reboot to work again. mii-diag output gives wierd data such as
> the MAC address set to ff:ff:ff:ff:ff:ff. Looking at the patch code, it seems that 
> pci_save_state() and pci_restore_state(), among other things, implements this. 
> Will this work with APM's suspend/sleep functions?

It has better chances to work now.

	Andrey
