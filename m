Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWEOVR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWEOVR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWEOVRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:17:34 -0400
Received: from mx.pathscale.com ([64.160.42.68]:26757 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S965244AbWEOVR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:17:28 -0400
Subject: Re: [PATCH 14 of 53] ipath - forbid empty MRs
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
In-Reply-To: <adalkt3uw7g.fsf@cisco.com>
References: <5d9fbba3222eeb941679.1147477379@eng-12.pathscale.com>
	 <adalkt3uw7g.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 14:17:27 -0700
Message-Id: <1147727847.2773.21.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 08:46 -0700, Roland Dreier wrote:
>  > Don't allow zero-length regions to be created.
> 
> Why are zero-length regions forbidden?

One of the gen2 basic tests checks for zero-length regions and barfs if
someone creates them.  There's no language in IBNA that forbids
zero-length regions (I'll take a look at the spec itself to be sure), so
it's possible that the test is wrong.  On the other hand, a zero-length
region doesn't seem terribly useful.

	<b

