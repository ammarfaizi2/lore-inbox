Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270081AbTHBSiT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270093AbTHBSiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:38:19 -0400
Received: from holomorphy.com ([66.224.33.161]:35556 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270081AbTHBSiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:38:16 -0400
Date: Sat, 2 Aug 2003 11:39:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bug in setpgid()? process groups and thread groups
Message-ID: <20030802183929.GA32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
References: <1059811048.18516.43.camel@ixodes.goop.org> <3F2B7435.7070101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2B7435.7070101@redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 01:20:05AM -0700, Ulrich Drepper wrote:
> The problem is that Linus already said it is too late for this for 2.6.
>  So we are waiting for a signal that the time is right.  The changes
> will be substantial since all the different IDs should be covered.

I think callers can be converted incrementally, so long as the
transition is (unfortunately) slow. I can help devise a patch breakup
plan or do other footwork (e.g. code) if you want or need helpers.


-- wli
