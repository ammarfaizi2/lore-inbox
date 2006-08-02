Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWHBHqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWHBHqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWHBHqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:46:07 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:8102 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751354AbWHBHqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:46:06 -0400
Message-ID: <44D05821.1040209@sgi.com>
Date: Wed, 02 Aug 2006 09:45:37 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: nagar@watson.ibm.com, jlan@sgi.com, linux-kernel@vger.kernel.org,
       balbir@in.ibm.com, csturtiv@sgi.com, tee@sgi.com
Subject: Re: [patch 3/3] convert CONFIG tag for a few accounting data used
 by CSA
References: <44CE58AF.7030200@sgi.com>	<44CE6AE7.8020304@watson.ibm.com>	<44D0538A.3090600@sgi.com> <20060802003102.c8cb1a47.akpm@osdl.org>
In-Reply-To: <20060802003102.c8cb1a47.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 02 Aug 2006 09:26:02 +0200
> Jes Sorensen <jes@sgi.com> wrote:
>> Shailabh Nagar wrote:
>>> static inlines preferred
>> Huh? Is that a preference to the taskstat project? For the kernel
>> itself it makes no difference.
> 
> static inlines provide typechecking and typo checking and presence-of-x
> checking when the option is configged off.  They can also suppress unused
> variable warnings.
> 
> And they're C, not cpp ;)

That I agree with, I guess I normally just draw the line between
functions that do actual work versus empty dummies like in this case.

Cheers,
Jes
