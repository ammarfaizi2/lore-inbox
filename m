Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWDVBH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWDVBH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWDVBH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:07:59 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:4083 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750826AbWDVBH6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:07:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=npnjF6bcBhlwafvUnE67b1lVpXGDn4kVL0CrYF0XZ6t315HT6to6hxMfb9johSduv/QHp1UjPq7Y5CpTfxy3RpqIXZW7p2JRnAIf7Hx0970HHSjQWoEbMal8Ku3bkIdzDPue1VI8KwdFhvszE2R+UFmEM2qbk8RcwrG9BdWdekI=
Message-ID: <787b0d920604211807l2b08dd31h8bcc36bdea1e4379@mail.gmail.com>
Date: Fri, 21 Apr 2006 21:07:58 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: gcc stack problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported that problem involving asmlinkage and prevent_tail_call.
I hope I got the details right. Here it is:

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27234

Note comment #3, suggesting that following the ABI would
be a better way to write the assembly.
