Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278659AbRJ3W5E>; Tue, 30 Oct 2001 17:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278613AbRJ3W4y>; Tue, 30 Oct 2001 17:56:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44296 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278667AbRJ3W4p>; Tue, 30 Oct 2001 17:56:45 -0500
Subject: Re: What is standing in the way of opening the 2.5 tree?
To: jack@suse.cz (Jan Kara)
Date: Tue, 30 Oct 2001 23:03:43 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), jgarzik@mandrakesoft.com,
        miles@megapathdsl.net, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011030192902.B22781@atrey.karlin.mff.cuni.cz> from "Jan Kara" at Oct 30, 2001 07:29:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yhv5-0001YY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   The second patch is patch which implements new quota format. It makes
> changes in quotactl() interface and other changes visible in userspace.
> I think that is the reason why Linus doesn't want it in 2.4 and I agree with him.

The problem is that without it 32bit uids are useless. That means any real
world ldap using customer can't use Linus quotas.

I'd really like to figure a way the code can handle both at once
