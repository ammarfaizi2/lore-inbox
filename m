Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVD2AeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVD2AeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 20:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVD2AeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 20:34:11 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:12496 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S262357AbVD2AeF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 20:34:05 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Daniel Phillips <phillips@istop.com>, linux-kernel@vger.kernel.org
Date: Thu, 28 Apr 2005 17:33:52 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH 0/7] dlm: overview
In-Reply-To: <20050428145715.GA21645@marowsky-bree.de>
Message-ID: <Pine.LNX.4.62.0504281731450.6139@qynat.qvtvafvgr.pbz>
References: <20050425151136.GA6826@redhat.com> <200504271600.57993.phillips@istop.com>
 <20050427202009.GE4431@marowsky-bree.de> <200504271838.18441.phillips@istop.com>
 <20050428145715.GA21645@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005, Lars Marowsky-Bree wrote:

> On 2005-04-27T18:38:18, Daniel Phillips <phillips@istop.com> wrote:
>
>> Uuids's at this level are inherently bogus, unless of course you have more
>> than 2**32 cluster nodes.  I don't know about you, but I do not have even
>> half that many nodes over here.
>
> This is not quite the argument. With that argument, 16 bit would be
> fine. And even then, I'd call you guilty of causing my lights to flicker
> ;-)
>
> The argument about UUIDs goes a bit beyond that: No admin needed to
> assign them; they can stay the same even if clusters/clusters merge (in
> theory); they can be used for inter-cluster addressing too, because they
> aren't just unique within a single cluster (think clusters of clusters,
> grids etc, whatever the topology), and finally, UUID is a big enough
> blob to put all other identifiers in, be it a two bit node id, a
> nodename, 32bit IPv4 address or a 128bit IPv6.
>
> This piece is important. It defines one of the fundamental objects in
> the API.
>
> I recommend you read up on the discussions on the OCF list on this; this
> has probably been one of the hottest arguments.

how is this UUID that doesn't need to be touched by an admin, and will 
always work in all possible networks (including insane things like backup 
servers configured with the same name and IP address as the primary with 
NAT between them to allow them to communicate) generated?

there are a lot of software packages out there that could make use of 
this.

David Lang
