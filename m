Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWBSTGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWBSTGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 14:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWBSTGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 14:06:44 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:45472 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932213AbWBSTGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 14:06:44 -0500
Date: Sun, 19 Feb 2006 11:06:40 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Irfan Habib <irfanhab@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to find the CPU usage of a process
Message-ID: <20060219190640.GA4929@taniwha.stupidest.org>
References: <20060218174229.76852.qmail@web32603.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218174229.76852.qmail@web32603.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 09:42:29AM -0800, Irfan Habib wrote:

> I wanted to ask how can I find the cpu usage of a process, as
> opposed to runtime, with cpu usage I mean actually how many time
> slices were awarded to a specific process, like the runtime of job
> may be 4 s, but this also includes time it was suspended by some
> interrupt, or had to wait for the scheduler etc..

getrusage(2) or if it's not a child then grovel through /proc (i think
there is an argument for a better interface)
