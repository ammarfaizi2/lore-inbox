Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273032AbTHFAx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273033AbTHFAx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:53:57 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47115
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S273032AbTHFAxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:53:50 -0400
Date: Tue, 5 Aug 2003 17:53:48 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: hsdm <hsdm@hsdm.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it possible to add this feature.
Message-ID: <20030806005348.GB15764@matchmail.com>
Mail-Followup-To: Kurt Wall <kwall@kurtwerks.com>, hsdm <hsdm@hsdm.com>,
	linux-kernel@vger.kernel.org
References: <3F3049D0.6040804@hsdm.com> <20030806003054.GN6541@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806003054.GN6541@kurtwerks.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 08:30:54PM -0400, Kurt Wall wrote:
> Quoth hsdm:
> > Is it posible to limit the amount of memory or CPU time per user?
> 

Basically, no.

> ulimit -m
> ulimit -t

This is per session, and the user can have many sessions.  Unless you limit
the number of sessions a user can have...
