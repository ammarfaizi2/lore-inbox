Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265903AbUGJCcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbUGJCcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 22:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUGJCcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 22:32:51 -0400
Received: from holomorphy.com ([207.189.100.168]:41089 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265903AbUGJCcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 22:32:48 -0400
Date: Fri, 9 Jul 2004 19:32:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org,
       linux-c-programming <linux-c-programming@vger.kernel.org>
Subject: Re: Garbage Collection and Swap
Message-ID: <20040710023245.GE21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org,
	linux-c-programming <linux-c-programming@vger.kernel.org>
References: <40EF3BCD.7080808@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EF3BCD.7080808@comcast.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 08:43:57PM -0400, John Richard Moser wrote:
> Read that.  It's in all caps, so you should read it.  It has meaning.
> How about, everything is using Bohem GC.  Bohem wanders around in the
> heap concurrently.  So all of your applications are wandering around
> through their vm space everywhere, continuously.
> You get low on ram.  Let's say an app is using 500M of ram (Mozilla).
> What's going to happen?  Obvious.  It's going to yank shit out of swap.
> If we all linked against a GC, what kinds of swap hell do you think we'd
> encounter?

Ones almost as bad as the Hell of trolls going nuts over hypothetical
problems no one is stupid enough to cause in practice anyway.


-- wli
