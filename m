Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265436AbSJXOBb>; Thu, 24 Oct 2002 10:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265445AbSJXOBb>; Thu, 24 Oct 2002 10:01:31 -0400
Received: from ma-northadams1b-3.bur.adelphia.net ([24.52.166.3]:384 "EHLO
	ma-northadams1b-3.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S265436AbSJXOBa>; Thu, 24 Oct 2002 10:01:30 -0400
Date: Thu, 24 Oct 2002 10:20:34 -0400
From: Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44-ac2: stack overflow in acpi_initialize_objects
Message-ID: <20021024102034.A102@ma-northadams1b-3.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.44-ac2 compiled for Athlon with gcc-3.2 fails to boot with a
really exciting stack overflow that dumps hordes of stack trace on the
screen. I'm too lazy to write it all down, but the last line before
'init' refers to acpi_initialize_objects.

I can write down more of it if needed.

-Eric

