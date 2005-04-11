Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVDKLiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVDKLiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 07:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVDKLiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 07:38:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4828 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261782AbVDKLiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 07:38:08 -0400
Subject: Re: Problem in log_do_checkpoint()?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jeffm@suse.com, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1112980478.32606.236.camel@dyn318077bld.beaverton.ibm.com>
References: <20050404090414.GB20219@atrey.karlin.mff.cuni.cz>
	 <1112980478.32606.236.camel@dyn318077bld.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113219463.2164.41.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 11 Apr 2005 12:37:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-04-08 at 18:14, Badari Pulavarty wrote:
> I get OOPs  in log_do_checkpoint() while using ext3 quotas.
> Is this anyway related to what you are working on ?
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000

Doesn't look like it, no.  If we understand it right, Jan's problem
would only ever manifest itself as an assert failure, not as an oops.

--Stephen

