Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTELL72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 07:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTELL72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 07:59:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44951
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262072AbTELL71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 07:59:27 -0400
Subject: Re: [PATCH] restore sysenter MSRs at resume
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305111706370.22268-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305111706370.22268-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052738012.31246.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 12:13:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 01:07, Linus Torvalds wrote:
> On 11 May 2003, Alan Cox wrote:
> > 
> > Some laptops also lose all the AGP settings in the chipset.
> 
> Well, that's definitely a driver issue, and should be handled that way. I
> suspect even the MTRR's should be handled as a driver, since unlike things
> like the SYSENTER things, it really _is_ a driver already and is
> conditional on kernel configuration etc.

True, although mtrr is kind of special because bad things happen in some
cases if they dont match across CPU's or with I/O device mappings.


