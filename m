Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTAXDL5>; Thu, 23 Jan 2003 22:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbTAXDL5>; Thu, 23 Jan 2003 22:11:57 -0500
Received: from web80307.mail.yahoo.com ([66.218.79.23]:58523 "HELO
	web80307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267528AbTAXDL5>; Thu, 23 Jan 2003 22:11:57 -0500
Message-ID: <20030124032103.2302.qmail@web80307.mail.yahoo.com>
Date: Thu, 23 Jan 2003 19:21:03 -0800 (PST)
From: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030123192829.A628@nightmaster.csn.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> wrote:

> Yes, what you do is nice, but generates much code. What about
> this for pushfl:

Your code snipped is 10% slower.  I'm not sure if it's the extra
stack activity or the 8bit user of registers (which can
pose a hazard to the execution stream on some processors).
I'm gunning for high performance.

-Kevin

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
