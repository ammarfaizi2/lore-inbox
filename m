Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWBYD54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWBYD54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 22:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbWBYD54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 22:57:56 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:1440 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932601AbWBYD54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 22:57:56 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dave Jones <davej@redhat.com>
Subject: Re: multimedia keys on dell inspiron 8200s.
Date: Fri, 24 Feb 2006 22:57:53 -0500
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20060224014947.GA17397@redhat.com>
In-Reply-To: <20060224014947.GA17397@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602242257.54062.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 20:49, Dave Jones wrote:
> We've been carrying this patch in Fedora for way too long.
> So long, I've forgotten a lot of the history.
> 
> Aparently, it makes multimedia buttons on Dell Inspiron 8200's
> produce keycodes.  The only reference to this I found was
> at http://linux.siprell.com/, but I don't know if that's its origin.
> 

Dave,

This patch was refused before. Any additional/non-standard mapping is
to be done in userspace (you need to properly adjust xorg.conf anyway):

http://bugzilla.kernel.org/show_bug.cgi?id=2817#c4

> ------- Additional Comment #4 From Vojtech Pavlik 2005-07-03 00:19 -------
> I will not accept this patch (or any similar patch) to extend the
> atkbd.c mapping table - only standard scancodes are allowed there. The
> table is easily modified from userspace, and that is the way to go.
>
> In the past I tried to fill the table with all the entries, but found
> out that there are two or three keyboards competing for every position
> in the scancode table, with a different keycode.

-- 
Dmitry
