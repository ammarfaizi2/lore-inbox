Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTENV66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTENV66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:58:58 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:17165 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S262945AbTENV65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:58:57 -0400
Date: Thu, 15 May 2003 00:11:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andreas Schwab <schwab@suse.de>
cc: Miles Bader <miles@gnu.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new kconfig goodies
In-Reply-To: <jellx9b62v.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.44.0305142358590.5042-100000@serv>
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
 <buou1bz7h9a.fsf@mcspd15.ucom.lsi.nec.co.jp> <Pine.LNX.4.44.0305131710280.5042-100000@serv>
 <20030513211749.GA340@gnu.org> <Pine.LNX.4.44.0305142014500.5042-100000@serv>
 <jellx9b62v.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 May 2003, Andreas Schwab wrote:

> |> But I'm open to suggestions for a better name, "select" might be a good 
> |> alternative. Other ideas? Opinions?
> 
> How about "override"?

Hmm, I think it doesn't really fit, it's a bit more than this, e.g. if one 
option is set 'm', the other option can still be set to 'm' or 'y'. The 
logic is basically "if this option is selected, automatically select this 
other option too.", so currently I like "select" best.

bye, Roman

