Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263183AbTCYSFM>; Tue, 25 Mar 2003 13:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263184AbTCYSFM>; Tue, 25 Mar 2003 13:05:12 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:58566 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263183AbTCYSFG>; Tue, 25 Mar 2003 13:05:06 -0500
Date: Tue, 25 Mar 2003 18:16:05 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling options?
Message-ID: <20030325181558.GA8068@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030325180334.GH15678@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325180334.GH15678@rdlg.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 01:03:34PM -0500, Robert L. Harris wrote:

 > Is there anything good written up on if this is the best way for our 4
 > person admin team to keep managing this or should the boxes be custom
 > tuned for specific groups of machines within reason?  "What does it buy
 > us" is one of the big questions as swapping out that many kernels and
 > testing 5-8 different varriants is a big buyin on time.

Depends largely on the workload. Compiling a kernel targetted at
Athlon/Duron will factor in the 3dnow memory copying code which speeds
up bulk copies quite a lot. If your workload doesn't involve that much
memory copying, you'll likely not notice that much of a difference
though.

		Dave

