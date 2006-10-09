Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWJIVBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWJIVBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 17:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWJIVBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 17:01:54 -0400
Received: from main.gmane.org ([80.91.229.2]:11461 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964860AbWJIVBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 17:01:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: 09 Oct 2006 22:55:55 +0200
Message-ID: <87k639fbtw.fsf@willow.rfc1149.net>
References: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr> <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org> <5267.1160381168@redhat.com> <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr> <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com> <11639.1160398461@redhat.com> <Pine.LNX.4.61.0610092159340.23379@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jan" == Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>  That only offsets the problem a bit.  You still have to derive
>> uint32_t from somewhere.

Jan> The compiler could make it available as a 'fundamental type' -
Jan> i.e.  available without any headers, like 'int' and 'long'.

The compiler isn't allowed to pollute your namespace with symbols like
that. What if someone defines uint32_t as a function for example in
her code? (yes, this would be sick, but is allowed by default)

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

