Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbUCPGzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 01:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUCPGzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 01:55:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52421 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263481AbUCPGzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 01:55:09 -0500
Message-ID: <4056A47F.7070904@pobox.com>
Date: Tue, 16 Mar 2004 01:53:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
CC: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       prism54-devel@prism54.org, netdev <netdev@oss.sgi.com>,
       linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: Re: Prism54 Driver Project Complete
References: <20040316055249.GE24063@ruslug.rutgers.edu> <4056983B.9010609@pobox.com> <20040316063856.GH24063@ruslug.rutgers.edu>
In-Reply-To: <20040316063856.GH24063@ruslug.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis R. Rodriguez wrote:
> Well in that case we'll also act as the "official" prism54 patch
> recipients/senders. And by "we" I mean any of the prism54 developers
> listed on our project page. We can do this but we can only do this if the
> patches are sent to *us* based on clean bk trees. It's important that
> patches are sent to *us* prior to inclusion in the kernel since this
> driver is not the normal 1-file driver. If a patch goes into the driver
> in the kernel tree but not ours it's going to be a pain mantaining our
> tree / writing patches for you (as was done just now), specially since
> we're still a heavily active driver project. 

That's not scalable, since the upstream tree should not bottleneck on 
another tree.

If "prism54 dev team" are active maintainers, and respond to feedback 
and users patches, _most_ patches will come from you.  But this is never 
a guarantee...  Also, you should expect that developers often work 
exclusively with the upstream tree, so patches from outside developers 
will be diff'd against latest upstream BK.

I think we all want the same thing...  a decent prism54 maintained by 
folks that know it best.  For the prism54 dev team, that means keeping 
track of any upstream changes.  For the Linux community's part, the 
standard etiquette is to mail a patch to the driver's maintainer. 
Sometimes this etiquette is bypassed for stuff like:  first-time merges, 
changes that affect large numbers of drivers (of which prism54 just 
happens to be one of) in Linux, and simple build fixes from architecture 
maintainers.

	Jeff



