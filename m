Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbTEEMzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 08:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTEEMzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 08:55:10 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:54145 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262167AbTEEMzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 08:55:10 -0400
Date: Mon, 5 May 2003 14:06:41 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Art Haas <ahaas@airmail.net>, linux-kernel@vger.kernel.org
Subject: Re: Latest GCC-3.3 is much quieter about sign/unsigned comparisons
Message-ID: <20030505130641.GA13082@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Tomas Szepe <szepe@pinerecords.com>, Art Haas <ahaas@airmail.net>,
	linux-kernel@vger.kernel.org
References: <20030504212256.GE24907@debian> <20030505074803.GA1775@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505074803.GA1775@louise.pinerecords.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 09:48:04AM +0200, Tomas Szepe wrote:
 > > ... has eliminated all the warnings that GCC-3.3 by default printed
 > > with regards to signed/unsigned comparisons. A build of today's BK
 > > with this compiler is much quieter than those previously done
 > > with the 3.3 snapshots.
 > 
 > Is this a good thing, though?  I'm quite sure those warnings were useful.

In a lot of cases, they were just noise. They are still there with
-W if you really want to see them.

		Dave

