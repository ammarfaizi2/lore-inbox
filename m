Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbTIDQPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTIDQPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:15:23 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:55772 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265149AbTIDQOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:14:39 -0400
Date: Thu, 4 Sep 2003 09:14:37 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2nd proc not seen
Message-ID: <20030904091437.A25107@google.com>
References: <20030904021113.A1810@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904021113.A1810@google.com>; from fcusack@fcusack.com on Thu, Sep 04, 2003 at 02:11:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 02:11:13AM -0700, Frank Cusack wrote:
> I think I've seen some recent talk about this problem.  I have an HPAQ
> xw6000 w/ 2xP4 CPUs.  A RH kernel finds both CPUs (4 if I enable HT).  A
> kernel.org kernel only finds 1 (2 if I enable HT).

Works with 2.4.22.  If anyone is interested, I'll followup with the exact
change from 2.4.21 that makes this work (I need to figure that out anyway).
It's NOT the recent apic.c changes (local APIC), at least not by itself.

/fc
