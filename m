Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030886AbWK3Rvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030886AbWK3Rvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030898AbWK3Rvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:51:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:53073 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030886AbWK3Rvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:51:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=agQUMWrcDDiTKEWvEHIu3AnY13FBwISqVMos66CjoHS1Q/uqmdKC3ZCPuneAiBxvtIpN4NJXiTBfd4MQEpg3eO+5Ntbtas+IyXksl5F3XB6Ulrss/wHMAdDDTrMscXPr+fNbWjdwvOHbcTY15zbXBA+hLrL9W3kFp9f0Wq1qWcU=
Message-ID: <41840b750611300951o2a2c7be6uc1e91b504c8ef7b8@mail.gmail.com>
Date: Thu, 30 Nov 2006 19:51:38 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Cc: "Elias Oltmanns" <eo@nebensachen.de>, "Jens Axboe" <jens.axboe@oracle.com>,
       "Christoph Schmid" <chris@schlagmichtod.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061130171910.GD1860@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7ibks-1fg-15@gated-at.bofh.it> <7kpjn-7th-23@gated-at.bofh.it>
	 <7kDFF-8rd-29@gated-at.bofh.it> <87d5783fms.fsf@denkblock.local>
	 <20061130171910.GD1860@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/06, Pavel Machek <pavel@ucw.cz> wrote:
> Should we have kernel doing auto-unfreeze? Perhaps we can just mlock()
> the daemon?

You could be in the middle of suspend with by-now-frozen userspace; or
maybe the daemon had a SEGV or was accidentally killed. Can't trust
that.

  Shem
