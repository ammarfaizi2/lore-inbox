Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbUKWUen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbUKWUen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUKWUcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:32:36 -0500
Received: from mail19.bluewin.ch ([195.186.18.65]:19926 "EHLO
	mail19.bluewin.ch") by vger.kernel.org with ESMTP id S261232AbUKWUac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:30:32 -0500
Date: Tue, 23 Nov 2004 21:30:23 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Greg KH <greg@kroah.com>
Cc: Simon Fowler <simon@himi.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] visor: Don't count outstanding URBs twice
Message-ID: <20041123203023.GA13663@k3.hellgate.ch>
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041123193604.GA12605@k3.hellgate.ch> <20041123194557.GB1196@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123194557.GB1196@kroah.com>
X-Operating-System: Linux 2.6.10-rc2 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004 11:45:58 -0800, Greg KH wrote:
> Your email client is putting headers in the messages that say not to do
> this.  Please fix your client :)

D'oh! Fixed (I think).

> But I'm not seeing people actually hit the write limit, according to the
> logs that people are posting.

What I found is bound to cause exactly the kind of problem Simon
described, so I didn't check any further. _But_ comparing his log and
the code, I can't help but notice that the missing "write limit hit"
is the only instance of a dev_dbg in this driver. Coincidence?

Roger
