Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVLFPsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVLFPsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVLFPsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:48:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:59571 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750730AbVLFPsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:48:36 -0500
Subject: RE: [PATCH] aic79xx should be able to ignore HostRAID enabled
	adapters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Luvella McFadden <luvella@us.ibm.com>, AJ Johnson <blujuice@us.ibm.com>,
       Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Dec 2005 19:06:19 +0000
Message-Id: <1133550379.3515.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-01 at 08:44 -0500, Salyzyn, Mark wrote:
> I have on numerous attempts tried to contact Heinz Mauelshagen to
> fortify dmraid in support of the HostRAID adapters. He has yet to
> respond to my emails to start a dialogue with Adaptec.

That suprises me. Heinz does respond to things and actively asks for
help on stuff like dmraid

> Justin Gibbs had provided the community the emd driver, soundly rejected
> and never ported to dm because there were features that Justin held dear
> in md that do not translate to dm. An unfortunate waste of considerable
> resources.

Please understand Justin Gibbs gave the Linux community emd in about as
productive a way that the US/UK government "gave" Iraq democracy.
Whatever the reasons for that and where the fault lies is another matter
but the result was not productive.

For long term maintenance and sanity reasons Linux is about doing things
in a logical consistent manner. Many people have had to learn to do
things the way Linus wants or the kernel expects, me included. It is
from that sort of process we have the current excellent e100 ethernet
driver still from Intel but not at all the Intel original for example.

We've consistently avoided hiding software raid behind magical
abstractions. There are numerous reasons for this. We want disks to move
between controllers easily for example, which vendors usually want to
make as painful as possible to create lockin.

