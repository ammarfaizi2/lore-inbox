Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWHXEM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWHXEM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 00:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWHXEM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 00:12:57 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:47003 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030274AbWHXEM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 00:12:56 -0400
Subject: Re: Areca arcmsr kernel integration for 2.6.18?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Theodore Bullock <tbullock@nortel.com>, robm@fastmail.fm,
       brong@fastmail.fm, erich@areca.com.tw, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1156375551.4306.10.camel@mentorng.gurulabs.com>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm>
	 <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com>
	 <20060731200309.bd55c545.akpm@osdl.org>
	 <1154530428.3683.0.camel@mulgrave.il.steeleye.com>
	 <1156375551.4306.10.camel@mentorng.gurulabs.com>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 23:11:57 -0500
Message-Id: <1156392717.26289.44.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 17:25 -0600, Dax Kelson wrote:
> It would be great if the arcmsr driver could be included in 2.6.18 so it
> can make into all the new distro releases that will be happening the
> last 3-4 months of the year.
> 
> It is completely self contained and it isn't changing any existing code
> (ergo it can't break anything) so I believe there is quite a bit of
> precedence for "late" inclusion in 2.6.18?
> 
> There are lots of users of this hardware (myself included) that would be
> very appreciative.

Well ... really no.  Kernel development isn't about distro releases.
Most of them pull from the upstream git trees anyway, so the problem
shouldn't arise.

There's precedent for putting relatively uncontroversial drivers into
the -rc tree.  However, arcmsr has had a rather difficult path into the
kernel.  Moving it into scsi-misc is a signal that it goes from being
out of tree to in-tree candidate (i.e. I'm happy with the quality now,
but I'll give other people a chance to voice concerns), but on a slow
path that allows people time to find problems and fix them.  This path
also dictates a time line for any final objections arising (i.e. up
until 2.6.18 is declared).

James


