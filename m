Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWGMDgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWGMDgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 23:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWGMDgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 23:36:37 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:43721 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1750763AbWGMDgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 23:36:36 -0400
Date: Thu, 13 Jul 2006 04:36:27 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@vaio.testbed.de
To: Kay Sievers <kay.sievers@vrfy.org>
cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [x86_64] strange delays since 2.6.15 (was: Re: ohci1394:	aborting
 transmission)
In-Reply-To: <1152738848.3195.32.camel@pim.off.vrfy.org>
Message-ID: <Pine.NEB.4.64.0607130431090.355@vaio.testbed.de>
References: <Pine.LNX.4.64.0607100527200.10447@sheep.housecafe.de> 
 <44B203F4.1030903@s5r6.in-berlin.de>  <Pine.LNX.4.64.0607100852390.13858@sheep.housecafe.de>
  <44B253CE.3030308@s5r6.in-berlin.de>  <Pine.NEB.4.64.0607121247410.2796@vaio.testbed.de>
  <Pine.NEB.4.64.0607122134150.3497@vaio.testbed.de> <1152738848.3195.32.camel@pim.off.vrfy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006, Kay Sievers wrote:
>
> I'm pretty sure, it has nothing to do with this patch itself. You may
> want to look in your bootscripts where it hangs, not in the kernel.

strange though, that the script did not change but the kernel. But as 
it's triggered by userspace it has to be fixed in userspace. It was 
quite a good exercise to use git-bisect: from 1500+ changesets down to 1 
single diff in a few hours...very cool!

Christian.
-- 
BOFH excuse #369:

Virus transmitted from computer to sysadmins.
