Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUD1UEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUD1UEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUD1UDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:03:38 -0400
Received: from main.gmane.org ([80.91.224.249]:57796 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261580AbUD1TVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:21:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Subject: Re: [BUG] DVD writing in 2.6.6-rc2
Date: Wed, 28 Apr 2004 21:20:10 +0200
Organization: Cocytus
Message-ID: <aoc5m1-lk3.ln1@legolas.mmuehlenhoff.de>
References: <1083088772.2679.11.camel@tiger> <20040427183607.GA3011@suse.de> <8n23m1-g22.ln1@legolas.mmuehlenhoff.de> <20040428113056.GA2150@suse.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p50869d16.dip.t-dialin.net
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> This is really strange, I haven't been able to locate a kernel problem.

In the case of k3b it turned out to be a bug in growisofs from the
dvd+rw-tools package; with the hotfix included in Debian/sid every-
things works as expected.
It seems very strange that both triggered a similar bug like this,
though.

