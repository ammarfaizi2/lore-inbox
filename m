Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSCZKrG>; Tue, 26 Mar 2002 05:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSCZKq4>; Tue, 26 Mar 2002 05:46:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27291 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310241AbSCZKqp>;
	Tue, 26 Mar 2002 05:46:45 -0500
Date: Tue, 26 Mar 2002 02:42:10 -0800 (PST)
Message-Id: <20020326.024210.55219079.davem@redhat.com>
To: aj@suse.de
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: Problems with Tigon v0.97
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <ho1ye7tyqx.fsf@gee.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's an amd756 chipset bug.  bcm5700 chooses to work around it in
their driver, when it really belongs as a generic PCI fixup in
the kernel.
