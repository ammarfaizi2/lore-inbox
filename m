Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268185AbUIPRBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268185AbUIPRBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268382AbUIPQre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:47:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29396 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268368AbUIPQqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:46:01 -0400
Date: Thu, 16 Sep 2004 12:45:50 -0400
From: Alan Cox <alan@redhat.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: tty drivers take two
Message-ID: <20040916164550.GA20766@devserv.devel.redhat.com>
References: <20040916143057.GA15163@devserv.devel.redhat.com> <1095347152.2006.17.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095347152.2006.17.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 10:05:52AM -0500, Paul Fulghum wrote:
> Would it be reasonable to add that to the
> helper and remove it from the individual drivers.

I was looking at that but some of them do the wakeup before and
some after and I've not had time to figure out if the order ever
matters
