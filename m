Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVE3ShU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVE3ShU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVE3Sgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:36:43 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:17558 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261709AbVE3SfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:35:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=OonVE+z8MfSWSngVA9kV3WTdTndCB4UR77/FdUSejLpU2WEg8oF/adjQvv70l/2jRIH8u30PQlPPBCWCBzUo5GGLRcC9XtyuxDrf31a1xfHrFDaK7gWD9KZxrjcNSdaoYgS2OqiJ7kpVnjXx32Co3wmQ7x1c0PGxyHYMVamPAF4=
Message-ID: <429B5CD3.7080106@gmail.com>
Date: Mon, 30 May 2005 20:34:59 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Erik Slagter <erik@slagter.name>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com>	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>	 <1117438192.4851.29.camel@localhost.localdomain>  <429B56CA.5080803@rtr.ca> <1117477364.3108.2.camel@localhost.localdomain> <429B5A94.6010301@rtr.ca>
In-Reply-To: <429B5A94.6010301@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord schrieb:

> Erik Slagter wrote:>
>
>> Still I'd like to run in ACHI mode ;-)
>
>
> Me too!  But from reading the ICH6 Intel docs,
> it seems that AHCI mode is only for true SATA drives.
>
> Or perhaps I've mis-read that part.
>
> Cheers
>
Well your're right NCQ i only a feature of SATA drives (native ones) not
like the SATA drives
that uses Marvell Brigde chip (orig. PATA) like Samsung SP80 SPxxxx series.
The new ones are real SATA drives. But some PATA devices and controllers
support TCQ.
There're surviral docs about this..also Jeff Garzik mentoined it on his
libata doc site.


Greets and best regards

    Michael
