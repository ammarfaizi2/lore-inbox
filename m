Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSLQQaH>; Tue, 17 Dec 2002 11:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSLQQaH>; Tue, 17 Dec 2002 11:30:07 -0500
Received: from [134.106.55.1] ([134.106.55.1]:1421 "EHLO walker.pmhahn.de")
	by vger.kernel.org with ESMTP id <S265140AbSLQQaG>;
	Tue, 17 Dec 2002 11:30:06 -0500
Date: Tue, 17 Dec 2002 16:15:07 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Greg Kroah-Hartman <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUGlet] security/Kconfig
Message-ID: <20021217151507.GA21929@walker.pmhahn.de>
Mail-Followup-To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: UUCP-Freunde Lahn e.V.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It was and is still strange when reading this, but

from linux/security/root_plug.c:
[...]
 * Prevents any programs running with egid == 0 if a specific USB device
   ^^^^^^^^
 * is not present in the system.  Yes, it can be gotten around, but is a
      ^^^^^^^^^^^

from linux/security/Kconfig
[...]
	  This is a sample LSM module that should only be used as such.
	  It enables control over processes being created by root users
	     ^^^^^^^
	  if a specific USB device is not present in the system.
	                              ^^^
I thinks, that "not" should not be in Kconfig.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
