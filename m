Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161277AbWHJNzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161277AbWHJNzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161285AbWHJNzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:55:05 -0400
Received: from [81.2.110.250] ([81.2.110.250]:33762 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161277AbWHJNzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:55:04 -0400
Subject: Re: Merging libata PATA support into the base kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <20060810122056.GP11829@suse.de>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <p733bc5nm5g.fsf@verdi.suse.de>
	 <1155213464.22922.6.camel@localhost.localdomain>
	 <20060810122056.GP11829@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Aug 2006 15:14:52 +0100
Message-Id: <1155219292.22922.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-10 am 14:20 +0200, ysgrifennodd Jens Axboe:
> You make it sound much worse than it is. Apart for HPA, I'm not aware of
> any setups that require extra treatment. And the amount of reported bugs
> against it are pretty close to zero :-)

There are several variants where you get
	- hangs on resume
	- HPA mishandling
	- CRC errors and usually eventually a hang

HPA thankfully appears to bite only IBM thinkpad users

