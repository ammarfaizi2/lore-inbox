Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUFTMDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUFTMDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 08:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFTMDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 08:03:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7563 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263713AbUFTMDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 08:03:14 -0400
Date: Sun, 20 Jun 2004 08:02:48 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: Opteron bug
Message-ID: <20040620120247.GA21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200406192229.14296.rjwysocki@sisk.pl> <20040620152256.4a173a95.ak@suse.de> <200406201347.17967.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406201347.17967.rjwysocki@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 01:47:17PM +0200, R. J. Wysocki wrote:
> Well, is there any case in which the gcc can produce such stuff?

GCC doesn't ever generate std instruction (only cld), though users
can use it in inline assembly or assembly source file.
AFAIK x86_64 glibc doesn't use it at all either.

	Jakub
