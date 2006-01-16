Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWAPTiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWAPTiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWAPTiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:38:10 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:58788 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750778AbWAPTiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:38:09 -0500
Date: Mon, 16 Jan 2006 14:38:07 -0500
To: Christopher Friesen <cfriesen@nortel.com>
Cc: "Arne R. van der Heyde" <vanderHeydeAR@summitinstruments.com>,
       linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2004@gmx.net
Subject: Re: no carrier when using forcedeth on MSI K8N Neo4-F
Message-ID: <20060116193807.GW18970@csclub.uwaterloo.ca>
References: <43C7F35A.9010703@summitinstruments.com> <20060113222647.GB18972@csclub.uwaterloo.ca> <43C82BD5.2050904@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C82BD5.2050904@nortel.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 04:38:13PM -0600, Christopher Friesen wrote:
> Lennart Sorensen wrote:
> 
> >Gigabit does NOT use cross over cables.
> 
> I don't think this is always true.  Some gigabit ports can autosense 
> polarity and are able to use standard cables.  Others require gigabit 
> crossover cables.

Hmm, it appears you are right.  I have never seen a non autosensing
gigabit port, so I thought it was part of the spec.  Given the pairs all
send and receive already it seemed like an obvious part to include in
the spec.

Certainly a cross over cable made for 10/100 mbit won't work.  It needs
the other two pairs swapped to.  Most store bought cross over cables
seem to only have 10/100mbit in mind when they were made.

Proper pinout appears to be:
1 <-> 3
2 <-> 6
4 <-> 7
5 <-> 8

Len Sorensen
