Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbUJYNtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbUJYNtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbUJYNsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:48:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10368 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261806AbUJYNqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:46:17 -0400
Date: Mon, 25 Oct 2004 09:46:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Johan Groth <johan.groth@symbian.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: External USB harddisk problems
In-Reply-To: <417CFFDE.3070904@symbian.com>
Message-ID: <Pine.LNX.4.61.0410250941200.18851@chaos.analogic.com>
References: <417CFFDE.3070904@symbian.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Johan Groth wrote:

> Hi,
> I'm experiencing problems with a Maxtor USB HD drives that hope someone on 
> this list can shed some light on. When I try to copy a file to or from the HD 
> that is > 100MB the whole system hangs. I can't ping it from another systems, 
> nothing shows up in any logs so I don't know why it hangs. I'm using 
> 2.6.8-k7-smp from Debian unstable. The USB card is a 2.0 version with a Nec 
> chipset.
>
> Regards,
> Johan
>
> PS, please CC me as I'm not subscribed to this list.

Just some information.... Most of these external USB and/or
external Firewire disks such as ACOM, etc., contain an
EIDE (ATA) hard disk plus an adapter board with a
USB or IEEE sequencer. These sequencers can be a pain
in the ass because they do 8-bit math. It may be necessary
to artifically constrain the per-operation data-length
with this in mind.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
