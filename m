Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWBBHCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWBBHCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 02:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWBBHCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 02:02:03 -0500
Received: from smtpout.mac.com ([17.250.248.71]:8141 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932387AbWBBHCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 02:02:02 -0500
In-Reply-To: <1138857560.15691.0.camel@mindpipe>
References: <200602010609.k1169QDX017012@hera.kernel.org> <43E0F73B.6040507@pobox.com> <A9543B03-333E-470F-AD18-0313192ADB23@mac.com> <1138857560.15691.0.camel@mindpipe>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D1A90FC1-95F7-4C2B-BC6D-1F60000FC989@mac.com>
Cc: Mark Rustad <mrustad@mac.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] PCI: restore 2 missing pci ids
Date: Thu, 2 Feb 2006 02:01:41 -0500
To: Lee Revell <rlrevell@joe-job.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 02, 2006, at 00:19, Lee Revell wrote:
> On Wed, 2006-02-01 at 23:11 -0600, Mark Rustad wrote:
>> Why were the ids removed in the first place?
>
> Because they weren't used by anything in the tree.

Also, the new PCI-ID policy is to put the defines in the driver  
itself, near where it is used, instead of collecting them in a single  
file.  The goal is to minimize the number of unused PCI IDs in the  
tree by keeping the definition near the usage.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/ 
philosophy/) software stuff and not get a real job. Charles Schulz  
had the best answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because life wouldn't have any meaning for them if they didn't.  
That's why I draw cartoons. It's my life."
   -- Charles Schulz


