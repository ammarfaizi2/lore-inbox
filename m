Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVARPOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVARPOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVARPOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:14:37 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:32443 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261319AbVARPO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:14:27 -0500
Message-ID: <41ED27CD.7010207@us.ibm.com>
Date: Tue, 18 Jan 2005 09:14:21 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, paulus@samba.org,
       benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com> <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com> <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com> <1105454259.15794.7.camel@localhost.localdomain> <20050111173332.GA17077@muc.de> <1105626399.4664.7.camel@localhost.localdomain> <20050113180347.GB17600@muc.de> <1105641991.4664.73.camel@localhost.localdomain> <20050113202354.GA67143@muc.de>
In-Reply-To: <20050113202354.GA67143@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> As Brian said the device he was working with would just not answer,
> leading to a bus abort.  This would get ffffffff on a PC.
> You could simulate this if you want, although I think a EBUSY or EIO
> is better.

Alan - are you satisfied with the most recent patch, or would you prefer 
the patch not returning failure return codes and just bit bucketing 
writes and returning all ff's on reads? Either way works for me.


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
