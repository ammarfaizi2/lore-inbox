Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWC1AEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWC1AEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWC1AEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:04:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38571 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932104AbWC1AEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:04:36 -0500
Date: Mon, 27 Mar 2006 19:04:18 -0500
From: Dave Jones <davej@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: smp_locks reference_discarded errors
Message-ID: <20060328000418.GB19025@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060325033948.GA15564@redhat.com> <20060325235035.5fcb902f.akpm@osdl.org> <20060326154042.GB13684@redhat.com> <20060326161055.GA4584@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326161055.GA4584@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 06:10:55PM +0200, Sam Ravnborg wrote:

 > Also the output from modpost provides a bit more info.
 > So output from fresh -linus kernel would make it easier to locate the
 > guilty stuff.

Finally coaxed latest -git to build on all archs I care about..
grab http://people.redhat.com/davej/buildlog.txt  and grep for WARNING:
and see a zillion errors.  The smp_locks ones seem to have disappeared
now though.

		Dave

-- 
http://www.codemonkey.org.uk
