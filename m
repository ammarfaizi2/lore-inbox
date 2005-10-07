Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbVJGQU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbVJGQU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030485AbVJGQU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:20:29 -0400
Received: from xenotime.net ([66.160.160.81]:9389 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030484AbVJGQU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:20:28 -0400
Date: Fri, 7 Oct 2005 09:20:27 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Steven Rostedt <rostedt@goodmis.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dell firmware default config options?
In-Reply-To: <Pine.LNX.4.58.0510071209140.8299@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510070919280.7817@shark.he.net>
References: <43469A9A.2070104@beezmo.com> <Pine.LNX.4.58.0510071209140.8299@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005, Steven Rostedt wrote:

>
> I'm just curious why the Dell firmware configuration options are default
> to "m" instead of "n".  Since it only matters if you have a Dell System.
>
> So for the huge number of systems that are not Dell Systems, they are
> probably wasting CPU cycles compiling these as modules, and taking up
> space in loads of /lib/modules directories throughout the world ;-)
>
> DCDBAS explicitly states default of "m", and DELL_RBU has no default which
> just makes it automatically on.
>
> Is there any reason that these shouldn't be turned off by default?

Agreed, and there's already been a patch to do that.
It's probably sitting in -mm... (just guessing), but could
easily move upward IMO.

-- 
~Randy
