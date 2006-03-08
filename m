Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWCHVnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWCHVnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWCHVnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:43:06 -0500
Received: from mx.pathscale.com ([64.160.42.68]:56809 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750841AbWCHVnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:43:05 -0500
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store
	buffers
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: akpm@osdl.org, ak@suse.de, paulus@samba.org, bcrl@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1141853919.11221.183.camel@localhost.localdomain>
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
	 <1141853919.11221.183.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 13:43:28 -0800
Message-Id: <1141854208.27555.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 08:38 +1100, Benjamin Herrenschmidt wrote:

> I think people already don't undersatnd the existing gazillion of
> barriers we have with quite unclear semantics in some cases, it's not
> time to add a new one ...

What do you suggest I do, then?  This makes a substantial difference to
performance for us.  Should I confine this somehow to the ipath driver
directory and have a nest of ifdefs in an include file there?

	<b

