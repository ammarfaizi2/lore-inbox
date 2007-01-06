Return-Path: <linux-kernel-owner+w=401wt.eu-S932099AbXAFTUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbXAFTUp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbXAFTUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:20:45 -0500
Received: from [139.30.44.16] ([139.30.44.16]:10832 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932099AbXAFTUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:20:44 -0500
Date: Sat, 6 Jan 2007 20:20:42 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression?  hdparm shows 1/2...1/3 the throughput
In-Reply-To: <459FE2AF.2020507@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.63.0701062018530.29044@gockel.physik3.uni-rostock.de>
References: <459FE2AF.2020507@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007, Stefan Richter wrote:

> Did anybody else notice this?  The result of "hdparm -t" under 2.6.20-rc
> seems to be less than half of what you get on 2.6.19.  However, disk I/O
> did *not* get slower according to bonnie++.

yes. See
  http://lkml.org/lkml/2007/1/2/75
for the solution.

Tim
