Return-Path: <linux-kernel-owner+w=401wt.eu-S1422769AbXAMUDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbXAMUDZ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 15:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422770AbXAMUDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 15:03:25 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:55294 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422769AbXAMUDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 15:03:24 -0500
Message-ID: <45A93B02.7040301@citd.de>
Date: Sat, 13 Jan 2007 21:03:14 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Knutsson <ricknu-0@student.ltu.se>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
References: <45A9092F.7060503@student.ltu.se>
In-Reply-To: <45A9092F.7060503@student.ltu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson wrote:

> Any thoughts on this is very much appreciated (is there any flaws with
> this?).

The thought that crossed my mind was:

Why not do the same thing that was done to the "Help"-file. (Before it
was superseded by Kconfig).

Originaly there was a central Help-file, with all the texts. Then it was
split and placed in each sub-dir. And later it was superseded by Kconfig.

On the other hand you could skip the intermediate step and just fold the
Maintainer-data directly into Kconfig, that way everything is "in one
place" and you could place a "Maintainers"-Button next to the
"Help"-Button in *config, or just display it alongside the help.

And MAYBE that would also lessen the "update-to-date"-problem, as you
can just write the MAINTAINERs-data when you create/update the
Kconfig-file. Which is a thing that creates much bigger pain when you
forget it accidently. ;-)

Oh, and it neadly solves the mapping-problem, for at least all
kernel-parts that have a Kconfig-option/Sub-Tree.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

