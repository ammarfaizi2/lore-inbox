Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTDIVNW (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTDIVNW (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:13:22 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:19985 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263818AbTDIVNV (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 17:13:21 -0400
Date: Wed, 9 Apr 2003 23:24:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_INPUT problems
In-Reply-To: <85360000.1049918540@flay>
Message-ID: <Pine.LNX.4.44.0304092316080.5042-100000@serv>
References: <193480000.1049909378@[10.10.2.4]> <Pine.LNX.4.44.0304092154320.5042-100000@serv>
 <85360000.1049918540@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Apr 2003, Martin J. Bligh wrote:

> > config INPUT
> > 	default y if !HEADLESS
> 
> I don't see how that'll work ... we already have it defaulting to y,
> but there's a previous setting that's 'n' from the 2.4 config file
> they're upgrading from ... and that overrides the default, right?

A default without a visible prompt works like derived variable.
If there is prompt, the .config value and the default value is used as 
default input for the prompt.

bye, Roman

