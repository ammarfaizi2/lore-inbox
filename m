Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbTC0P6d>; Thu, 27 Mar 2003 10:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263116AbTC0P6d>; Thu, 27 Mar 2003 10:58:33 -0500
Received: from cathy.bmts.com ([216.183.128.202]:34240 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id <S263062AbTC0P6c>;
	Thu, 27 Mar 2003 10:58:32 -0500
Date: Thu, 27 Mar 2003 11:09:43 -0500
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Much better framebuffer fixes.
Message-Id: <20030327110943.703c7894.mikeserv@bmts.com>
In-Reply-To: <3E82CB28.8020001@aitel.hist.no>
References: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
	<3E82CB28.8020001@aitel.hist.no>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003 10:58:00 +0100
Helge Hafting <helgehaf@aitel.hist.no> wrote:

> The lilo approach:
> append="video=radeonfb:1280x1024-24@60"
> This seems to do nothing.  I get the same low resolution as
> plain 2.5.66, which looks bad as it don't match the flat screen resolution.
>

I just got a new box a few weeks ago and after building my kernel, struggled for an hour until I did a google search and found some other sod who was doing the same thing as me. It's not "radeonfb:" it's simply "radeon:"

This is the mode I use

append = "video=radeon:1024x768-8@85"

Grogan
