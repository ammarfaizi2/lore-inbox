Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274705AbRJFAID>; Fri, 5 Oct 2001 20:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274708AbRJFAHx>; Fri, 5 Oct 2001 20:07:53 -0400
Received: from smtp-ham-1.netsurf.de ([194.195.64.97]:38582 "EHLO
	smtp-ham-1.netsurf.de") by vger.kernel.org with ESMTP
	id <S274705AbRJFAHg>; Fri, 5 Oct 2001 20:07:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Tim Waugh <twaugh@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: User-level USB device drivers, and permissions
Date: Sat, 6 Oct 2001 02:08:34 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <20011005125116.K7197@redhat.com>
In-Reply-To: <20011005125116.K7197@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011006000747Z274705-760+21348@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> An idea in my head is to have a pam module that, for console users,
> mounts -tusbdevfs none /somewhere/usb-bus/$LOGNAME with user ownership
> on login and dismounts it on logout, but I don't know if that is
> feasible.

This is way too coarse. This control needs to be there on a device level at 
least.

> Does anyone know if this problem has already been solved, or else can
> they think of a solution?

The current conventional wisdom is to use chmod in the hotplug scripts and 
logout scripts.
This has been discussed in connection with a SANE backend for Microtek 3600 
scanners.

	Regards
		Oliver
