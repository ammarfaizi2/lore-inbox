Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUGEUVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUGEUVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 16:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUGEUV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 16:21:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9355 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261605AbUGEUV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 16:21:28 -0400
From: Daniel Phillips <phillips@redhat.com>
Organization: Red Hat
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Mon, 5 Jul 2004 16:27:51 -0400
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <200407050209.29268.phillips@redhat.com> <200407051442.27397.phillips@redhat.com> <20040705191204.GE6845@marowsky-bree.de>
In-Reply-To: <20040705191204.GE6845@marowsky-bree.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407051627.51790.phillips@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Monday 05 July 2004 15:12, Lars Marowsky-Bree wrote:
> On 2004-07-05T14:42:27,
>
>    Daniel Phillips <phillips@redhat.com> said:
> > Don't you think we ought to take a look at how OCFS and GFS might
> > share some of the same infrastructure, for example, the DLM and
> > cluster membership services?
>
> Indeed. If your efforts in joining the infrastructure are more
> successful than ours have been, more power to you ;-)

What problems did you run into?

On a quick read-through, it seems quite straightforward for quorum, 
membership and distributed locking.

The idea of having more than one node fencing system running at the same 
time seems deeply scary, we'd better make some effort to come up with 
something common.

Regards,

Daniel
