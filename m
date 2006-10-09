Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWJIKDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWJIKDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 06:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWJIKDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 06:03:42 -0400
Received: from mout1.freenet.de ([194.97.50.132]:5603 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751014AbWJIKDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 06:03:41 -0400
Date: Mon, 09 Oct 2006 12:05:05 +0200
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: [PATCH 8/11] 2.6.18-mm3 pktcdvd: bio write congestion control
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "petero2@telia.com" <petero2@telia.com>
Content-Type: text/plain; charset=iso-8859-15
MIME-Version: 1.0
References: <op.tguqidxpiudtyh@master> <20061003152859.GQ7778@kernel.dk>
Content-Transfer-Encoding: 7bit
Message-ID: <op.tg5a1kuoiudtyh@master>
In-Reply-To: <20061003152859.GQ7778@kernel.dk>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the idea was to give the user/admin the ability to control
cpu load and memory consumption while the driver write to
DVD / CD, at least for testing purposes.
Maybe move this interface into debugfs?

-Thomas


Am 03.10.2006, 17:29 Uhr, schrieb Jens Axboe <jens.axboe@oracle.com>:

> On Tue, Oct 03 2006, Thomas Maier wrote:
>> Hello,
>>
>> this patch adds the ability to control the size of the drivers
>> bio write queue.
>
> imho, this should not be a configuration option. The driver is perfectly
> capable of sizing this queue appropriately (determined by the device)
> without user interaction. Basically the option just needs to prevent the
> system from falling over, just choose some low sane value.
>


