Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265122AbTFEUjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbTFEUjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:39:22 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:63037 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265122AbTFEUjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:39:19 -0400
Message-ID: <3EDFAC88.4040609@rackable.com>
Date: Thu, 05 Jun 2003 13:48:08 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugo Mills <hugo-lkml@carfax.org.uk>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       andre@linux-ide.org, alan@redhat.com
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
References: <20030605193514.GB1542@carfax.org.uk>
In-Reply-To: <20030605193514.GB1542@carfax.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2003 20:52:51.0067 (UTC) FILETIME=[6DA50CB0:01C32BA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugo Mills wrote:

>   I've just taken delivery of a shiny new Adaptec 1210SA Serial-ATA
>adapter and a 120Gb Seagate Barracuda native SATA drive. Problem is,
>the kernel driver doesn't seem to notice this device on boot --
>nothing at all appears relating to this device in the boot messages.
>Can you help me?
>
>   I'm not a kernel hacker, I'm afraid, but I can apply patches and
>test stuff for this card+drive as much as you like...
>
>   (The card is configured in its on-board BIOS with a single disk as
>JBOD).
>
>  
>

  The card is a serial ata controller with what adaptec refers to as 
"hostraid".  (Meaning the raid is done in the driver.)  There are binary 
drivers for it on adptec's site, but no open source drivers.  The binary 
drivers are fairly good, but they are binary drivers.  (Which brings the 
headaches that binary drivers entail.)

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


