Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbUK3DqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbUK3DqB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 22:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUK3DqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 22:46:01 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:63619 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261966AbUK3Dp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 22:45:56 -0500
Date: Mon, 29 Nov 2004 19:45:55 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: efficeon and longrun
In-Reply-To: <cogd81$2nt$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.61.0411291835500.18845@twinlark.arctic.org>
References: <16810.26231.936086.930240@metzlerbros.de> <cogd81$2nt$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2004, H. Peter Anvin wrote:

> longrun-0.9 is hideously out of date, and was never debugged to begin
> with.  Given that these days longrun is handled via cpufreq, there
> doesn't seem to be much reason for the standalone longrun program.

the tool still has a place... for folks not using cpufreq/2.6 especially.  
but also the longrun cpufreq driver is lacking support for 
scaling_available_frequencies, and doesn't display the voltages anywhere.  
in most cases the ACPI P-states driver works fine instead though.

i prefer the tool -- but then my requirements are pretty specific (i don't 
want cpufreq doing anything i'm not expecting while doing perf/debugging 
work).

-dean
