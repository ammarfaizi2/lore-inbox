Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbQJ1JlK>; Sat, 28 Oct 2000 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129171AbQJ1JlA>; Sat, 28 Oct 2000 05:41:00 -0400
Received: from devserv.devel.redhat.com ([207.175.42.156]:30470 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129131AbQJ1Jko>; Sat, 28 Oct 2000 05:40:44 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200010280940.e9S9eSx02362@devserv.devel.redhat.com>
Subject: Re: [PATCH] Make agpsupport work with modversions
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 28 Oct 2000 05:40:28 -0400 (EDT)
Cc: dwmw2@infradead.org (David Woodhouse), vojtech@suse.cz (Vojtech Pavlik),
        alan@redhat.com (Alan Cox), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org
In-Reply-To: <5122.972699496@ocs3.ocs-net> from "Keith Owens" at Oct 28, 2000 01:18:16 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cc list trimmed.  Nobody has come up with a "must have" reason for
> get_module_symbol and that interface is broken as designed.  I will be

Nobody has come up with a 'must break existing sane code' reason either.

> will allow two objects to pass data to each other, it will not matter
> whether the objects are both modules, one module and one built in (in
> either order) or both built in.  When modules are involved there will
> be full module locking.

You have no consensus on this. None at all. It is also past the 2.4test
point for making this change.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
