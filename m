Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbTJPUSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbTJPUSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:18:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31172 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263159AbTJPUSf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:18:35 -0400
Message-ID: <3F8EFD0B.1010508@pobox.com>
Date: Thu, 16 Oct 2003 16:18:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: John Bradford <john@grabjohn.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, val@nmt.edu
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove>	 <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com>	 <20031016162926.GF1663@velociraptor.random>	 <20031016172930.GA5653@work.bitmover.com>	 <200310161828.h9GISxlN001783@81-2-122-30.bradfords.org.uk> <1066329102.5398.43.camel@localhost>
In-Reply-To: <1066329102.5398.43.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> On Thu, 2003-10-16 at 14:28, John Bradford wrote:
> 
> 
>>Surely it's just common sense to say that you have to verify the whole
>>block - any algorithm that can compress N values into <N values is
>>lossy by definition.  A mathematical proof for that is easy.
> 
> 
> That is the problem.
> 
> But those pushing this approach argue that the chance of collision is
> less than the chance of hardware errors, et cetera.


Nod.  And there are certainly ways to avoid hash collisions...

	Jeff



