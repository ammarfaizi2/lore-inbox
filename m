Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbRGLV1Q>; Thu, 12 Jul 2001 17:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266668AbRGLV1G>; Thu, 12 Jul 2001 17:27:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54028 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266608AbRGLV1F>; Thu, 12 Jul 2001 17:27:05 -0400
Subject: Re: ACPI fundamental locking problems
To: pavel@suse.cz (Pavel Machek)
Date: Thu, 12 Jul 2001 22:27:47 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik), andrew.grover@intel.com,
        linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
In-Reply-To: <20010710004415.A557@bug.ucw.cz> from "Pavel Machek" at Jul 10, 2001 12:44:15 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Knzv-0006vr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You already rely on BIOS to boot your kernel. What if that evil
> binary-only BIOS just readed keystrokes stored in 8042, and is sending
> contents of your harddrive over network during memory test?

The bios loads a public key signed executable which is mostly crypted. The 
disk sees only encrypted fs requests.

Alan

