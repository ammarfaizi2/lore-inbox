Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWBFSil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWBFSil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWBFSil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:38:41 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:39952 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932226AbWBFSik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:38:40 -0500
Message-ID: <43E7977A.1010509@cfl.rr.com>
Date: Mon, 06 Feb 2006 13:37:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Neil Brown <neilb@suse.de>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <"787b0d92060 <m3lkwogxmc.fsf@defiant.localdomain>
In-Reply-To: <m3lkwogxmc.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Feb 2006 18:40:14.0605 (UTC) FILETIME=[C4CF0BD0:01C62B4C]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14251.000
X-TM-AS-Result: No--1.400000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Out of curiosity, what commands does hal send the drive that can 
interrupt burning?  I've been reading the MMC-5 standard lately and it 
looks like while the drive is burning, attempts to send it other 
commands that would interfere with the burn are supposed to be failed 
with an error code indicating that a burn is in progress, and thus, 
avoid making a coaster. 

Krzysztof Halasa wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
>
>   
>> But that again sounds like hald won't use O_EXCL, therefore could always be 
>> able to open the device and potentially send commands which interrupt cd 
>> writing.
>>     
>
> Yep. Both need that. And I need some coffee to recover from
> non-logical thinking.
>   

