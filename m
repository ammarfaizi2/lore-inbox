Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129147AbQJZWXR>; Thu, 26 Oct 2000 18:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129187AbQJZWXH>; Thu, 26 Oct 2000 18:23:07 -0400
Received: from devserv.devel.redhat.com ([207.175.42.156]:33540 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129147AbQJZWWz>; Thu, 26 Oct 2000 18:22:55 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200010262221.e9QMLfC32276@devserv.devel.redhat.com>
Subject: Re: [PATCH] Make agpsupport work with modversions
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 26 Oct 2000 18:21:41 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), moz@compsoc.man.ac.uk (John Levon),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        alan@redhat.com, faith@valinux.com, jhartmann@precisioninsight.com
In-Reply-To: <20001019102722.B9057@suse.cz> from "Vojtech Pavlik" at Oct 19, 2000 10:27:22 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, this is usually handled by a third module that takes care of
> registering/unregistering the existence of the two modules that need to
> be possible to load/unload separately.

But that module then depends on both of the others unless you keep recompiling
it


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
