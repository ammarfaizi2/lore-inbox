Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbTDNRjN (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTDNRjN (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:39:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19982 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263585AbTDNRjK (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:39:10 -0400
Date: Mon, 14 Apr 2003 18:50:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Bourne <jbourne@hardrock.org>
Cc: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Martin Schlemmer <azarah@gentoo.org>,
       Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
Message-ID: <20030414185052.D22754@flint.arm.linux.org.uk>
Mail-Followup-To: James Bourne <jbourne@hardrock.org>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Martin Schlemmer <azarah@gentoo.org>,
	Ken Brownfield <brownfld@irridia.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	KML <linux-kernel@vger.kernel.org>
References: <20030414144709.GE10347@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0304141048390.24506-100000@cafe.hardrock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304141048390.24506-100000@cafe.hardrock.org>; from jbourne@hardrock.org on Mon, Apr 14, 2003 at 11:09:02AM -0600
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 11:09:02AM -0600, James Bourne wrote:
> will need to be looked at as these are ones which contain references to
> SUBVERSION...  References to EXTRAVERSION also reside in these files.  It
> would just be better to do the "right thing" IMHO.

Note that EXTRAVERSION is not numeric.  A kernel version string can be
like:

2.4.19-rmk7-pxa2

which definitely is not numeric.  Anything which assumes it is would be
broken.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

