Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWGDQZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWGDQZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWGDQZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:25:29 -0400
Received: from ns.suse.de ([195.135.220.2]:51858 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932270AbWGDQZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:25:28 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
Date: Tue, 4 Jul 2006 18:25:07 +0200
User-Agent: KMail/1.9.3
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com> <200607041723.46604.ak@suse.de> <Pine.LNX.4.64.0607040915420.13795@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607040915420.13795@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607041825.07466.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 July 2006 18:16, Christoph Lameter wrote:
> On Tue, 4 Jul 2006, Andi Kleen wrote:
> 
> > The 900MB refered to the boundary between NORMAL and HIGHMEM on i386.
> 
> Yikes. So any system with 1MB will need to have highmem? 

No. But a 1GB system will.

> I guess the 2G/2G config option changes that?

Yes, but it also breaks a lot of software.

-Andi
