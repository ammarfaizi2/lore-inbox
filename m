Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbTF2XDA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 19:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTF2XDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 19:03:00 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:18561 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S265029AbTF2XC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 19:02:59 -0400
From: Daniel Phillips <phillips@arcor.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC] My research agenda for 2.7
Date: Sun, 29 Jun 2003 01:18:18 +0200
User-Agent: KMail/1.5.2
Cc: Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306282354.43153.phillips@arcor.de> <20030629220756.GB26348@holomorphy.com>
In-Reply-To: <20030629220756.GB26348@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306290118.18266.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 June 2003 00:07, William Lee Irwin III wrote:
> On Sunday 29 June 2003 23:26, Mel Gorman wrote:
> > ...I will occupy myself with the
> > gritty details of how to move pages without making the system crater.
>
> This sounds like it's behind dependent on physically scanning slabs,
> since one must choose slab pages for replacement on the basis of their
> potential to restore contiguity, not merely "dump whatever's replaceable
> and check how much got freed".

Though I'm not sure what "behind dependent" means, and I'm not the one 
advocating slab for this, it's quite correct that scanning strategy would 
need to change, at least when the system runs into cross-order imbalances.  
But this isn't much different from the kinds of things we do already.

Regards,

Daniel

