Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWBHPSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWBHPSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWBHPSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:18:39 -0500
Received: from ns2.suse.de ([195.135.220.15]:44197 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030416AbWBHPSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:18:38 -0500
From: Andi Kleen <ak@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] add execute_in_process_context() API
Date: Wed, 8 Feb 2006 16:18:16 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel> <p737j86l1es.fsf@verdi.suse.de> <1139411751.3003.1.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1139411751.3003.1.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081618.16974.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 16:15, James Bottomley wrote:
>  The problem is that
> there's no real way to cope with failure in this case.

Then you can't use GFP_ATOMIC. You have to redesign.

-Andi
