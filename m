Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUF2Q7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUF2Q7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUF2Q7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:59:10 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:19115 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265817AbUF2Q6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:58:21 -0400
Date: Tue, 29 Jun 2004 17:57:43 +0100
From: Dave Jones <davej@redhat.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.7 Shows Two i8042's in /proc/interrupts?
Message-ID: <20040629165743.GA7245@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.60.0406291231040.10973@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0406291231040.10973@p500>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 12:32:49PM -0400, Justin Piszcz wrote:
 > I have APIC+ACPI+/dev/rtc enabled.
 > 
 > Curious though, why two i8042's?

keyboard & mouse.   Try watch -n1 cat /proc/interrupts
and wiggle mouse / press keys.

		Dave

