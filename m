Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTJ1R5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTJ1R5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:57:03 -0500
Received: from palrel10.hp.com ([156.153.255.245]:16073 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261151AbTJ1R5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:57:01 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16286.44522.275791.73904@napali.hpl.hp.com>
Date: Tue, 28 Oct 2003 09:56:58 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.or
Subject: Re: status of ipchains in 2.6?
In-Reply-To: <20031028015032.734caf21.davem@redhat.com>
References: <200310280127.h9S1RM5d002140@napali.hpl.hp.com>
	<20031028015032.734caf21.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 28 Oct 2003 01:50:32 -0800, "David S. Miller" <davem@redhat.com> said:

  DaveM> On Mon, 27 Oct 2003 17:27:22 -0800 David Mosberger
  DaveM> <davidm@napali.hpl.hp.com> wrote:

  >> I recently discovered that ipchains is rather broken.  I noticed
  >> the problem on ia64, but suspect that it's likely to affect all
  >> 64-bit platforms (if not 32-bit platforms).  A more detailed
  >> description of the problem I'm seeing is here:

  >> http://tinyurl.com/sm9d

  >> Unlike ipchains, iptables works perfectly fine, so perhaps we
  >> just need to update Kconfig to discourage ipchains on ia64
  >> (and/or other 64-bit platforms)?

  DaveM> Might want to post this to the netfilter lists or netdev....
  DaveM> Nah, that might actually get the bug fixed.

$ fgrep -i ipchain MAINTAINERS
$

Might want to consider updating the MAINTAINERS file?

	--david
