Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311251AbSCLPns>; Tue, 12 Mar 2002 10:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311253AbSCLPnj>; Tue, 12 Mar 2002 10:43:39 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:59656 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S311248AbSCLPnY>; Tue, 12 Mar 2002 10:43:24 -0500
Message-Id: <200203121545.g2CFjLI27269@aslan.scsiguy.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx: Slow negotiation? 
In-Reply-To: Your message of "Tue, 12 Mar 2002 15:20:24 GMT."
             <Pine.LNX.4.33.0203121519250.18363-100000@sphinx.mythic-beasts.com> 
Date: Tue, 12 Mar 2002 08:45:21 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Some MB manufacturers using the aic7895 screwed up the initialation of
>> the serial eeprom while they were assembling their boards.  The old
>> driver tries to work around this, but the work-around means converting
>> one of the lower sync rates into meaning "full speed". I decided that
>> just wasn't safe to put in the new driver.
>
>Is a warning printk() possible?

The printk would fire every time you chose to use this particular
negotiation rate.

--
Justin
