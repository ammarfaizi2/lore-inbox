Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVHAKBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVHAKBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 06:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVHAKBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 06:01:03 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:24121 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262332AbVHAKA6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 06:00:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eKI5C2Frncy0vKHC7NHK/FZY7dCsjpMfpMNqxtjZhTu0du3BLJAjhyVv0Ia3RWLAWnzxzawr/d0mC64F7ac8ZmHS5jHVfnYIm5hc4ThxM6J7OpU2HqNfV+qZVRW2oKsyPXTZe5aRt8YRLgHXe2SoQm7iBjqSIdvfwn56s+ktB8M=
Message-ID: <355e5e5e0508010300d0aedc9@mail.gmail.com>
Date: Mon, 1 Aug 2005 03:00:56 -0700
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
To: jgarzik@pobox.com
Subject: [PATCH 0/3] Add disk hotswap support to libata RESEND #2
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jeff, all,

The following is my latest attempt at re-doing the hotswap patches for
libata hotswapping.  This has some positive upsides:

- The patches seem cleaner
- The patches seem more multi-purpose and adaptable for use across all
controllers, not just the Promise ones.
- Jeff is more likely to accept them since most of his suggestions
have been factored in.

There is also a downside:

- The patches haven't been tested at ALL since I don't have any
hardware until September.

So, try at your own risk.  Everything seems sane to me, however it is
3:00 AM here.

Jeff, these patches are designed against 2.6.13-rc3-mm1.  As a result,
they are meant to apply overtop of the sata_promise 'support PATA
port' patch.

Please apply and try.  And send me comments about how the patches are
broken in weird scenarios.

Luke Kosewski
