Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUC1Dro (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 22:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUC1Dro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 22:47:44 -0500
Received: from ns.clanhk.org ([69.93.101.154]:36526 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S262077AbUC1Drl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 22:47:41 -0500
Message-ID: <40664AE4.8010003@clanhk.org>
Date: Sat, 27 Mar 2004 21:47:48 -0600
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Status of the sata_sil driver for the VT8237
References: <4066342B.4080105@clanhk.org> <406643A8.2050808@pobox.com>
In-Reply-To: <406643A8.2050808@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> J. Ryan Earl wrote:
>
>> I was wondering, what is the state of the sata_sil driver for the VIA 
>> VT8237 southbridge (ie the one used commonly on their K8T 
>> motherboards).  Is this still beta?  Any known problems with it?
>
>
> Well prior to the most recent version, calling it "beta" was putting 
> it kindly.  I would call it broken :) which was why it was marked with 
> CONFIG_BROKEN...
>
> As of the most recent 2.6.5-rc2-bk snapshots, libata and sata_sil 
> should be pretty happy with each other.

I meant sata_via, I dunno why I said sata_sil; Freudian typo.  I was 
thinking of the current sii3112 I use, which has been stable and 
blazingly fast for awhile with the IDE driver--and a little little patch 
I keep applying.  I'm looking to upgrade a server with 2 Raptors in it 
to an A64 running 64-bit Linux of course.  I wanna get the HDs off the 
PCI bus and onto the VT8237 southbridge.  I was wondering if the driver 
for -that southbridge- was still considered beta.

-ryan
