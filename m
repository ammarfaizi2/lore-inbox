Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbVKAImA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbVKAImA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVKAImA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:42:00 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:57998
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S965058AbVKAIlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:41:52 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/5] Swap Migration V5: Overview
Date: Tue, 1 Nov 2005 02:08:48 -0600
User-Agent: KMail/1.8
Cc: Christoph Lameter <clameter@sgi.com>, torvalds@osdl.org,
       kravetz@us.ibm.com, raybry@mpdtxmail.amd.com,
       linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       haveblue@us.ibm.com, magnus.damm@gmail.com, pj@sgi.com,
       marcelo.tosatti@cyclades.com, kamezawa.hiroyu@jp.fujitsu.com
References: <20051101031239.12488.76816.sendpatchset@schroedinger.engr.sgi.com> <20051031192506.100d03fa.akpm@osdl.org>
In-Reply-To: <20051031192506.100d03fa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010208.49662.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 21:25, Andrew Morton wrote:
> So I'll queue this up for -mm, but I think we need to see an entire
> hot-remove implementation based on this, and have all the interested
> parties signed up to it before we can start moving the infrastructure into
> mainline.
>
> Do you think the features which these patches add should be Kconfigurable?

Yes please.  At least something under CONFIG_EMBEDDED to save poor Matt the 
trouble of chopping it out himself. :)

Rob
