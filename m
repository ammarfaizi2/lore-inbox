Return-Path: <linux-kernel-owner+w=401wt.eu-S1751937AbXARFKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbXARFKx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 00:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbXARFKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 00:10:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:60763 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbXARFKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 00:10:52 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=XycXpy7t+Ov22k5WDFRLPIrJDnbTYiactTH3dBrgtwk/NmNy/UycdJwCEATWrd1wOmZ6J1Xosbkr9KUzElPyfQga/UBBvTBhWLr9vRE/Nnhc0d8IeaXG6+aMGYxBd4uwzVCbnlvY7QQUo+WJNsgRj/s/3Bd7GakZzP+9zKXWBaY=
Date: Thu, 18 Jan 2007 07:10:26 +0200
To: Daniel Rodrick <daniel.rodrick@gmail.com>
Cc: kernelnewbies <kernelnewbies@nl.linux.org>,
       Linux Newbie <linux-newbie@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: after effects of a kernel API change
Message-ID: <20070118051026.GA29695@Ahmed>
References: <292693080701172015n736a269fl6945ba4fe19d8174@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <292693080701172015n736a269fl6945ba4fe19d8174@mail.gmail.com>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 09:45:04AM +0530, Daniel Rodrick wrote:
> Hi list,
> 
> Whenever there is a change in the kernel API (or a new API is
> introduced), all of the drivers that use the older API need to be
> changed (or recommended to be changed). I believe it is the
> responsibility of the person changing the kernel API, to change all
> the drivers that have found their way into the kernel code?
> 
> How does this happen? Because the person who brought the change in the
> API might not know the internals of all the drivers?
> 
> Is there any way volunteers like me can help in this exercise?

See the /APIchanges in the Kernel Janitors TODO list
http://kernelnewbies.org/KernelJanitors/Todo

Also: Documentation/stable_api_nonsense.txt

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
