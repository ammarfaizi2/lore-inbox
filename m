Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTFKJbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTFKJbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:31:12 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:14554 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264266AbTFKJbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:31:10 -0400
Date: Wed, 11 Jun 2003 10:44:41 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: I Am Falling I Am Fading <skuld@anime.net>
Cc: linux-kernel@vger.kernel.org, gregor.essers@web.de
Subject: Re: Via KT400 and AGP 8x Support
Message-ID: <20030611094441.GE14706@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	I Am Falling I Am Fading <skuld@anime.net>,
	linux-kernel@vger.kernel.org, gregor.essers@web.de
References: <Pine.LNX.4.53.0306110210220.27802@inconnu.isu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0306110210220.27802@inconnu.isu.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 02:28:24AM -0600, I Am Falling I Am Fading wrote:

 > I've had this problem as well.
 > 
 > What I've been able to do is to use a backport for one of the 2.4.21-pre*
 > series, and move the code forward to the current 2.4.21-rc's .

That's not a proper fix. The agp code in 2.4.21pre supports the KT400
only in AGP2.0 mode. When you put an AGP3.0 (x8) card in the slot,
the chipset configures itself into AGP3 mode, and registers change
meaning.

 > Here's info on the relevant patch:
 > http://lists.insecure.org/lists/linux-kernel/2003/Mar/3999.html

Very, very dated now. Many fixes have gone into the agp code since
2.5.64, on which that backport is based.

		Dave

