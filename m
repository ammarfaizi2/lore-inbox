Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290743AbSBLDBt>; Mon, 11 Feb 2002 22:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290744AbSBLDBj>; Mon, 11 Feb 2002 22:01:39 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:65272 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290743AbSBLDBa>;
	Mon, 11 Feb 2002 22:01:30 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.34183.282646.869983@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 19:01:27 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.185100.68039940.davem@redhat.com>
In-Reply-To: <15464.32354.452126.182563@napali.hpl.hp.com>
	<20020211.183603.111204707.davem@redhat.com>
	<15464.33256.837784.657759@napali.hpl.hp.com>
	<20020211.185100.68039940.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 18:51:00 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> It keeps your platform the same, and it does help other
  DaveM> platforms.

No, it will slow down ia64 and you haven't shown that it helps others.

  DaveM> This only leaves "I don't want to do the conversion because
  DaveM> it has no benefit to ia64."  Well, it doesn't hurt your
  DaveM> platform either, so just cope :-)

There are 9 other platforms.  Anton doesn't seem too happy about this
change either.  I don't know how the maintainers of the others feel.

	--david
