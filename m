Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTDHVyG (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTDHVyG (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:54:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39439 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261910AbTDHVyF (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 17:54:05 -0400
Message-ID: <3E934793.8070801@zytor.com>
Date: Tue, 08 Apr 2003 15:05:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Jes Sorensen <jes@wildopensource.com>, Martin Hicks <mort@bork.org>,
       linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: [patch] printk subsystems
References: <20030407201337.GE28468@bork.org> <20030408184109.GA226@elf.ucw.cz> <m3k7e4ycys.fsf@trained-monkey.org> <20030408210251.GA30588@atrey.karlin.mff.cuni.cz> <3E933AB2.8020306@zytor.com> <20030408215703.GA1538@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030408215703.GA1538@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Well, #define DEBUG in the driver seems like the way to go. I do not
> like "subsystem ID" idea, because subsystems are not really well
> defined etc.
>

I think that's a non-issue, because it's largely self-defining.  It's
basically whatever the developers want them to be, because they're the
ones who it needs to make sense to.

It should, however, be an open set, not a closed set like in syslog.

	-hpa

