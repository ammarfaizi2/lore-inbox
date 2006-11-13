Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755162AbWKMPs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbWKMPs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 10:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755163AbWKMPs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 10:48:58 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:35722 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1755162AbWKMPs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 10:48:58 -0500
Message-ID: <455893E5.4010001@garzik.org>
Date: Mon, 13 Nov 2006 10:48:53 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Pavel Machek <pavel@ucw.cz>, John Fremlin <not@just.any.name>,
       kernel list <linux-kernel@vger.kernel.org>, htejun@gmail.com,
       jim.kardach@intel.com
Subject: Re: AHCI power saving (was Re: Ten hours on X60s)
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org> <20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org> <200611131637.56737.ak@suse.de>
In-Reply-To: <200611131637.56737.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Therein lies a key problem.  Turning on all of AHCI's aggressive power 
>> management features DOES save a lot of power.  But at the same time, it 
>> shortens the life of your hard drive, particularly hard drives that are 
>> really PATA, but have a PATA<->SATA bridge glued on the drive to enable 
>> connection to SATA controllers.
> 
> How does it shorten its life?

Parks your hard drive heads many thousands of times more often than it 
does without the aggressive PM features.

	Jeff



