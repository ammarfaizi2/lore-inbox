Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUJOU4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUJOU4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 16:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268438AbUJOUz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 16:55:59 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:60555 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S268344AbUJOUy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 16:54:26 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDROM support in ata_piix?
References: <87k6txdte5.fsf@asmodeus.mcnaught.org>
	<41702358.1080203@pobox.com>
From: Doug McNaught <doug@mcnaught.org>
Date: Fri, 15 Oct 2004 16:54:12 -0400
In-Reply-To: <41702358.1080203@pobox.com> (Jeff Garzik's message of "Fri, 15
 Oct 2004 15:22:00 -0400")
Message-ID: <87acun7le3.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Doug McNaught wrote:
>> Is there any way to get ata_piix to register my CDROM, or
>> alternatively to have the regular IDE driver handle it? This seems
>> to be a known problem (it's filed as a Debian bug)--is it
>> fixed in 2.6.9-rc4?  I had a look at the -rc4 patch but couldn't tell
>> from the diff whether there's anything CDROM-related in there...
>
> Well, two things are going on:
>
> You may need to set CONFIG_BLK_DEV_SATA (or unset it) depending on
> your configuration.

I will look into this.

> Once you get past that, you need to apply the latest libata patch to
> fix a related combined mode bug.
>
> http://lkml.org/lkml/2004/10/14/336

I will probably wait until this trickles into a Linus kernel--I don't
have an immediate need for the CDROM (and I can boot 2.4 if I have
to). 

Thanks very much for the response!

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
