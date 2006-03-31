Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWCaTES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWCaTES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCaTES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:04:18 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:17423 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751289AbWCaTER convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:04:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ORcFTjjeBGgM+83bkyWYGMAah3rYLXacOZRMWpToCToLdiXcc9YVTk0YABoTf9y2xuwP6ckxyOl0aUphEShpCzfM6QqvkK7Hlu01OWlWsLTMtGrITI9kse+8lQsE1vzc4kykWQpMkFul8Da3FspZHC8SYedAKdTZBI5YLPxkkyI=
Message-ID: <41b516cb0603311104h617a0a7bnc0daefc024911f17@mail.gmail.com>
Date: Fri, 31 Mar 2006 11:04:14 -0800
From: "Chris Leech" <christopher.leech@intel.com>
Reply-To: chris.leech@gmail.com
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 2/9] I/OAT
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060330062124.GA8545@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1143672844.27644.5.camel@black-lazer.jf.intel.com>
	 <20060330062124.GA8545@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please describe how struct ioat_dma_chan channels are freed?

Sorry, I got distracted by other issues and never ended up following
up on this.  You're right, and it's just sloppiness on my part for
missing it, those structs are being leaked on module unload.  I'll fix
it.  Thanks.

-Chris
