Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUBREIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUBREHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:07:45 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:4258 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262686AbUBREF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:05:26 -0500
Date: Wed, 18 Feb 2004 04:02:52 +0000
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Re: 2.6.3rc4 ali1535 i2c driver rmmod oops.
Message-ID: <20040218040252.GJ6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
References: <20040218031544.GB26304@redhat.com> <Pine.LNX.4.58.0402171941580.2686@home.osdl.org> <20040218034925.GI6242@redhat.com> <Pine.LNX.4.58.0402171959560.2686@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171959560.2686@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 08:00:35PM -0800, Linus Torvalds wrote:

 > > I felt masochistic, so decided to 'see what would happen' when I ran this..
 > Whee. Fun. Do you actually have the hardware for it, or did it blow up 
 > even without any supported hardware?

-ENOHARDWARE.
Judging by the number of bugs this has thrown up, not many folks test the
'try a driver without the hardware' paths too often.

		Dave

