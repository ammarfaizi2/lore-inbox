Return-Path: <linux-kernel-owner+w=401wt.eu-S1030487AbXAHEHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbXAHEHN (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbXAHEHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:07:13 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:9323 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030487AbXAHEHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:07:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=T5P0b2waZ9/KAhiQydGn8Q+CE2JMOL1Xi8S3nTXi/PhOgbRfJP5ufDwAf2JOHeuUf73y1W9Q9PEHn7Fz+eyqFUl/EqkmaKBA5Z5rUe10FE83045Kvr3bTbzvD6rZeKgXldGR+WnpHM7XQIEtnADnp0SOe3AN59w1lJLc5dUavB8=
Message-ID: <45A1C367.5040005@gmail.com>
Date: Mon, 08 Jan 2007 13:07:03 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [RFC,PATCHSET] Managed device resources
References: <1167146313307-git-send-email-htejun@gmail.com> <20070104221916.GI28445@suse.de> <459D7F23.7010807@garzik.org> <20070104223247.GA29274@suse.de>
In-Reply-To: <20070104223247.GA29274@suse.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jan 04, 2007 at 05:26:43PM -0500, Jeff Garzik wrote:
>> Greg KH wrote:
>>> Hm, but I guess without the follow-up patches for libata, it will not
>>> really get tested much.  Jeff, if I accept this, what's your feelings of
>>> letting libata be the "test bed" for it?
>>
>> It would be easiest for me to merge this through my 
>> libata-dev.git#upstream tree.  That will auto-propagate it to -mm, and 
>> ensure that both base and libata bits are sent in one batch.
>>
>> Just shout if you see NAK-able bits...
>>
>> Work for you?
> 
> That works for me.

Great, I'll push it through Jeff.

> The only question I have is on the EXPORT_SYMBOL() stuff for the new
> driver/base/ functions.  Tejun, traditionally the driver core has all
> exported symbols marked with EXPORT_SYMBOL_GPL().  So, any objection to
> marking the new ones (becides the "mirror" functions) in this manner?

Okay, will do so.

Thanks.

-- 
tejun
