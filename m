Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUAPT7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265826AbUAPT7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:59:37 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:61058 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265825AbUAPT7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:59:32 -0500
Date: Fri, 16 Jan 2004 19:59:00 +0000
From: Dave Jones <davej@redhat.com>
To: David Ford <david+hb@blue-labs.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown CPU
Message-ID: <20040116195900.GA11919@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Ford <david+hb@blue-labs.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <40083E96.3020109@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40083E96.3020109@blue-labs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 02:42:14PM -0500, David Ford wrote:
 > I've an unknown cpu (athlon xp) in my machine.  What data do I need to 
 > collect so the kernel knows what it is?
 > 
 > # cat /proc/cpuinfo
 > processor       : 0
 > vendor_id       : AuthenticAMD
 > cpu family      : 6
 > model           : 10
 > model name      : Unknown CPU Type

That string gets read from the CPU directly, after the BIOS programs it.
Try and get an updated BIOS.

		Dave

