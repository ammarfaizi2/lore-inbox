Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWAXTVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWAXTVV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 14:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030495AbWAXTVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 14:21:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25255 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030313AbWAXTVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 14:21:21 -0500
Date: Tue, 24 Jan 2006 14:20:28 -0500
From: Dave Jones <davej@redhat.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Message-ID: <20060124192028.GA32499@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org
References: <20060124181945.GA21955@deprecation.cyrius.com> <20060124183432.GA27917@redhat.com> <20060124190839.GA16445@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124190839.GA16445@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 07:08:39PM +0000, Martin Michlmayr wrote:
 > * Dave Jones <davej@redhat.com> [2006-01-24 13:34]:
 > > Is there actually any practical reason why you would want to
 > > make the input layer modular ?
 > 
 > Not really, but if it doesn't work as a module then Kbuild shouldn't
 > allow you to configure it like that.

That's the point I'm trying to make.  If there's no good reason,
it may as well be boolean.

		Dave

