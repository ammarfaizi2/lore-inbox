Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbTLaPXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbTLaPXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:23:12 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:60546 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265158AbTLaPWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:22:46 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 31 Dec 2003 07:22:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Danny Cox <Danny.Cox@ECWeb.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-mm2 Surprises
In-Reply-To: <1072880245.1146.11.camel@vom>
Message-ID: <Pine.LNX.4.44.0312310717360.2312-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003, Danny Cox wrote:

> I've found some surprises in my testing of 2.6.0-mm2 on my RH 9 box.
> 
> First, 'make menuconfig' doesn't work.  It paints the top 8 or so lines,
> and freezes.  gnome-terminal begins using as much CPU as it's allowed. 
> This is similar to bug 959 in bugme.osdl.org, but changing CHILD_PENALTY
> from 90 to 130 didn't fix the problem.
> 
> Second, simply resizing gnome-terminal results in the same behavior. 
> Certainly, this may be a gnome thing.

Same here, I did not spent time investigating though.


> Third, 'rpm' cannot install packages.  It always exists with:

export LD_ASSUME_KERNEL=2.4



- Davide


