Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUDSQ4z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUDSQ4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:56:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11150 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261528AbUDSQ4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:56:31 -0400
Message-ID: <408404B2.30602@pobox.com>
Date: Mon, 19 Apr 2004 12:56:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Henrik Gustafsson <lkml@fnord.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: poor sata performance on 2.6
References: <200404150236.05894.kos@supportwizard.com> <1082001287.407e0787f3c48@webmail.LaTech.edu> <200404151455.36307.kos@supportwizard.com> <1082044297.407eaf894ddda@webmail.LaTech.edu> <407F1C07.6050104@umn.edu> <407F30F5.1070305@pobox.com> <opr6pp57mvesu439@mail1.telia.com>
In-Reply-To: <opr6pp57mvesu439@mail1.telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Gustafsson wrote:
> [cut]
> 
>> I _really_ like the SX4 -- it gives the programmer full control over 
>> all aspects of RAID operation, while providing useful hardware 
>> acceleration where it's needed.  And not getting in the way of the 
>> programmer, when it's not needed.
> 
> 
> Does this mean that the hardware-accelerated RAID5-mode will be 
> compatible with soft-RAID5? So that I am able to create a RAID5-array 
> today and get all the goodies from hardware-support later without having 
> to do the backup - recreate-array - restore dance?


Who knows.  It depends on the XOR algorithm block size and such.  I 
_think_ XOR'ing is compatible, but have not tested to verify that assertion.

	Jeff



