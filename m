Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWBMXPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWBMXPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWBMXPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:15:09 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:7441 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1030207AbWBMXPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:15:07 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: 2.6.16, sk98lin out of date
Date: Mon, 13 Feb 2006 23:15:08 +0000
User-Agent: KMail/1.9.1
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200602131058.03419.s0348365@sms.ed.ac.uk> <200602131110.34212.s0348365@sms.ed.ac.uk> <43F0E284.2040805@gentoo.org>
In-Reply-To: <43F0E284.2040805@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602132315.08494.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 19:48, Daniel Drake wrote:
> Alistair John Strachan wrote:
> > Thanks Matti, I wasn't even aware of this driver. Might I suggest the
> > "old" driver be marked as such in Linux 2.6.16. I guess I must've
> > skipped over it because it begins with "New", and does not contain
> > the word "Marvell", which is indicated exclusively by lspci.
>
> I changed the help text of all 3 drivers (sk98lin/skge/sky2) to
> point out which ones are/aren't interchangable in 2.6.16. The situation
> is a little confusing.

Thanks, this would have prevented my mistake.

> The reason that the sk98lin diff is so huge is because SysKonnect
> effectively added support for a substantially different range of cards
> (Yukon-2) into the existing driver. This is far from the driver quality
> required for the kernel today, so Stephen Hemminger (skge author) wrote
> a new driver (sky2) for the Yukon-2 range.
>
> The long term plan is to obsolete and remove sk98lin, but we aren't
> ready yet: skge issues pop up every month or two, and sky2 is young.
>
> Stephen's own words:
> > I applaud the initiative, but this it is too premature to obsolete
> > the existing driver. There may be lots of chip versions and other
> > variables that make the existing driver a better choice.

Well, Stephen's driver works great for me and sk98lin frankly didn't.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
