Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTH2IZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 04:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTH2IZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 04:25:51 -0400
Received: from main.gmane.org ([80.91.224.249]:23219 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264493AbTH2IZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 04:25:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables
 getting plugged in and out
Date: Fri, 29 Aug 2003 10:25:48 +0200
Message-ID: <yw1x1xv498fn.fsf@users.sourceforge.net>
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com> <20030829003426.GF12249@vitelus.com>
 <3F4EB641.3040107@davehollis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:HQpJJwbyZwTEDja1pwJo9KKdz/o=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David T Hollis <dhollis@davehollis.com> writes:

>>Thank you, thank you, thank you. I was just thinking today how
>>annoying it is that whenever I boot up my laptop, dhclient runs and tries
>>to get an IP address on the ethernet interface until it's ^C'd. Since
>>I often use the Ethernet interface this is not a bad default, but dhclient
>>can't even realize on its own that there's no cable plugged in.
> 
> Hmm, that seems to raise the question - why doesn't dhclient just
> handle that?  On a DHCP interface, it's running anyway.  if it paid
> attention to link status, it would know when to re-request an IP.  If
> you are statically assigned, you don't really care anyway.

Well, sometimes it's better to not have the interface configured UP
when there's no cable connected.  It avoids some very long timeouts
when some program tries to connect to something.  It's better to just
get a host unreachable error immediately.

-- 
Måns Rullgård
mru@users.sf.net

