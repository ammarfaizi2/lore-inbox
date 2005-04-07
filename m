Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVDGFFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVDGFFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 01:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVDGFFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 01:05:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8291 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261290AbVDGFFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 01:05:13 -0400
Date: Thu, 07 Apr 2005 01:03:39 -0400
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Low latency patches
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1112850219.7153.30.camel@localhost>
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
MIME-version: 1.0
X-Mailer: Evolution 2.0.4
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently come across Con Kolivas' isochronous scheduler and Ingo's
RLIMIT_RT_CPU patch. I cannot comment on Ingo's patch, but I've been
using Con's scheduler for a few days and I only have good things to say
about it (latency is as good as running the process as root). The only
thing missing is perhaps a way to enable the feature on a per-user basis
(e.g. enable only for owner of the console), though I'm not sure whether
it goes in kernel or user space.

Are there any plans on merging some of that work? I think it would
really help everyone doing audio (or other real-time stuff) on Linux.

	Jean-Marc

P.S. Please include me in CC, I'm not subscribed.

-- 
Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Université de Sherbrooke

