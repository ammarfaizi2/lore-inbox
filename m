Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUFJO5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUFJO5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 10:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUFJO4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 10:56:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6797 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261563AbUFJOzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 10:55:14 -0400
Date: Thu, 10 Jun 2004 15:55:08 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Message-ID: <20040610145508.GD6302@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040602154129.GO6302@agk.surrey.redhat.com> <20040609231805.029672aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609231805.029672aa.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 11:18:05PM -0700, Andrew Morton wrote:
> This pins at least 2MB of RAM up-front, even if devicemapper is not in use.
> Have you any plans to fix that up?

kcopyd used to create/destroy itself so it was only present while
it was being used.  Nobody can remember why that got changed so we'll
try reimplementing it.

Alasdair
-- 
agk@redhat.com
