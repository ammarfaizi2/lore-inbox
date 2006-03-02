Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWCBSQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWCBSQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbWCBSQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:16:29 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:23425 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S964771AbWCBSQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:16:29 -0500
Date: Thu, 2 Mar 2006 10:20:19 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: "Elangovan, Anush" <anush@fireeye.com>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org, gregkh@suse.de
Subject: Re: [PATCH] Define BITS_PER_BYTE to fix compilation error in 2.6.15.5
Message-ID: <20060302182019.GB3883@sorel.sous-sol.org>
References: <425BE87409B6BA49954C7D375C69F9ED025071B6@ms09.mse4.exchange.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425BE87409B6BA49954C7D375C69F9ED025071B6@ms09.mse4.exchange.ms>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Elangovan, Anush (anush@fireeye.com) wrote:
> 
> Looks like mm/mempolicy.c requires BITS_PER_BYTE, which is not defined in 2.6.15.5. Patch below fixes the issue. 2.6.16rc5 seems to have the #define 

Yes, thanks, similar patch is queued.
-chris
