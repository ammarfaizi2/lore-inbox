Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTIPIuE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 04:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTIPIuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 04:50:04 -0400
Received: from angband.namesys.com ([212.16.7.85]:42628 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261808AbTIPIuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 04:50:01 -0400
Date: Tue, 16 Sep 2003 12:49:59 +0400
From: Oleg Drokin <green@namesys.com>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another ReiserFS (rpm database) issue (2.6.0-test5)
Message-ID: <20030916084959.GA27971@namesys.com>
References: <Pine.LNX.4.53.0309141826030.9944@sjoerd.sjoerdnet> <20030915084031.GA510@namesys.com> <Pine.LNX.4.53.0309151824230.24113@sjoerd.sjoerdnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309151824230.24113@sjoerd.sjoerdnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Sep 15, 2003 at 06:34:00PM +0200, Arjan Filius wrote:

> > What if you mount your reiserfs partition with "-o nolargeio=1" mount option?
> Hey! this seems to "fix" it!
> With this option even my original "problem rpm databse" is rebuild in a
> few minutes, and without consuming that much memory, and without any
> errors!

That means you have a error in your rpm binary. Probably you want to contact SuSE to get updated version.

> Without the "nolargeio=1" i'd had to add a lot of swap (on my 1.5Gb RAM
> system), else it got just terminated. And adding a lot of swap i still got
> some fatal rpm errors.
> So it seems the "nolargeio=1" solves all my problems.

No, you just masked the problem, but the bug in your rpm binary is still present.

Bye,
    Oleg
