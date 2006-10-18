Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWJRFmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWJRFmw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 01:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWJRFmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 01:42:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47046 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751415AbWJRFmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 01:42:51 -0400
Date: Wed, 18 Oct 2006 01:42:42 -0400
From: Dave Jones <davej@redhat.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned
Message-ID: <20061018054242.GA21266@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017043726.GG29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 05:37:26AM +0100, Al Viro wrote:

 > There are several #includes with very high impact; the worst happens
 > to be module.h -> sched.h

I gave up fighting to get that fixed a year and a half ago..
http://lkml.org/lkml/2005/1/26/11

rediffing trees with lots of include file juggling gets boring real fast.

At one point, this was actually a noticable compile time win.

The other problem with things like this is they have a tendancy to
creep back in when no-one is specifically looking for them.

	Dave

-- 
http://www.codemonkey.org.uk
