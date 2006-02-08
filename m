Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWBHQH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWBHQH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWBHQH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:07:27 -0500
Received: from ns1.suse.de ([195.135.220.2]:1429 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965178AbWBHQH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:07:26 -0500
From: Andi Kleen <ak@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] add execute_in_process_context() API
Date: Wed, 8 Feb 2006 17:07:11 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel> <200602081618.16974.ak@suse.de> <1139414279.3003.25.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1139414279.3003.25.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081707.11791.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 16:57, James Bottomley wrote:
> On Wed, 2006-02-08 at 16:18 +0100, Andi Kleen wrote:
> > On Wednesday 08 February 2006 16:15, James Bottomley wrote:
> > >  The problem is that
> > > there's no real way to cope with failure in this case.
> > 
> > Then you can't use GFP_ATOMIC. You have to redesign.
> 
> My mailer seems to have deleted the part of the email with your redesign
> suggestion in it...
> 
> My initial point is that the current scsi_reap_target() infrastructure
> is more broken than the new API, so it does represent an improvement. 

An improvement that will randomly fail under high load.

-Andi
