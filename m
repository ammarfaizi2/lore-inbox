Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTERWZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTERWZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:25:42 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26810
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262235AbTERWZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:25:40 -0400
Date: Mon, 19 May 2003 00:38:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: need better I/O scheduler for bulk file serving
Message-ID: <20030518223831.GD1429@dualathlon.random>
References: <20030518195913.GA19275@codeblau.de> <20030518140642.64c7d619.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030518140642.64c7d619.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 02:06:42PM -0700, Andrew Morton wrote:
> Felix von Leitner <felix-kernel@fefe.de> wrote:
> >
> > Larger read-ahead maybe?
> 
> Or an anticipatory scheduler.  You don't say what kernel you're
> using.

yes, IMHO he could give a spin to my tree with better readahead and see
if it helps.

Andrea
