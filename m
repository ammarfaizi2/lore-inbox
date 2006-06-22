Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWFVNwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWFVNwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbWFVNwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:52:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5051 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161104AbWFVNwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:52:19 -0400
Date: Thu, 22 Jun 2006 14:51:17 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] dm: add exports
Message-ID: <20060622135117.GS19222@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060621193657.GA4521@agk.surrey.redhat.com> <20060621210504.b1f387bd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621210504.b1f387bd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 09:05:04PM -0700, Andrew Morton wrote:
> Twenty new exports.  What are they all for?

The exports correspond to the functionality available to userspace through
the existing ioctl interface.

Currently, we only offer an ioctl interface for device-mapper and this is
unsuitable for any future in-kernel users wishing to make use of
device-mapper facilities.

Alasdair
-- 
agk@redhat.com
