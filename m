Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTILLkU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 07:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbTILLkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 07:40:20 -0400
Received: from angband.namesys.com ([212.16.7.85]:17306 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261312AbTILLkS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 07:40:18 -0400
Date: Fri, 12 Sep 2003 15:40:16 +0400
From: Oleg Drokin <green@namesys.com>
To: Jesse Yurkovich <yurkjes@iit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bad directories w/Reiserfs on linux-2.6.0-test4
Message-ID: <20030912114016.GA7778@namesys.com>
References: <200309112144.09097.yurkjes@iit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309112144.09097.yurkjes@iit.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Sep 11, 2003 at 09:44:09PM -0500, Jesse Yurkovich wrote:

> >interesting... do you get the same empty dir (no . and ..) with ls?
> Yikes!!! -- hadn't noticed (CVS directory is bad for some reason)
> $ cd datatable-backup/CVS
> $ ls -la
> total 0			<-- not good   . and .. are not there
> whoa ... where did my parent go :(

So perhaps it is good idea to run reiserfsck (pick recent reiserfsprogs from ftp.namesys.com)

The reason for this is unknown, though.

Bye,
    Oleg
