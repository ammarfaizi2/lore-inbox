Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbUCEJXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUCEJXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:23:08 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:3970 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262269AbUCEJXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:23:04 -0500
To: Thomas Mueller <linux-kernel@tmueller.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 much worse than 2.4 on poor wlan reception
References: <20040304180154.GA1893@tmueller.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 05 Mar 2004 04:23:00 -0500
In-Reply-To: <20040304180154.GA1893@tmueller.com>
Message-ID: <yq0znavsl57.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Thomas" == Thomas Mueller <linux-kernel@tmueller.com> writes:

Thomas> Kernel 2.4 works far better in the poor reception situation I
Thomas> have, anyone any idea what I could do without moving the AP or
Thomas> laptop?  When I'm near my AP everything works fine with 2.6
Thomas> too.

Start out by forcing it to a lower link speed, at that signal quality
you really don't want to try and go above 2MBit/sec. If you keep
trying to do 11MBit/sec the card will constantly try the higher rate
and then lose signal, drop down and try again. Fixing the rate should
improve the situation - at least it has always done so for me ;-)

Cheers,
Jes
