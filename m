Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTINAzk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 20:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTINAzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 20:55:40 -0400
Received: from 62-37-18-165.dialup.uni2.es ([62.37.18.165]:35076 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262272AbTINAzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 20:55:39 -0400
Subject: Re: SII SATA request size limit
From: Eduardo Casino <casino_e@terra.es>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Sep 2003 02:57:58 +0200
Message-Id: <1063501078.11563.8.camel@centinela>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the SiImage closed-source driver release notes:

"Limitations:                                                                             ...
3. Mod15Write fix for Seagate Drives (for chipset versions 3112 1.21 or
older)"

strings sii6512.o | grep Mod15Write shows the following:
Mod15Write
ST320012AS::Mod15Write
ST330013AS::Mod15Write
ST340017AS::Mod15Write
ST360015AS::Mod15Write
ST380023AS::Mod15Write
ST3120023AS::Mod15Write
ST340014ASL::Mod15Write
ST360014ASL::Mod15Write
ST380011ASL::Mod15Write
ST3120022ASL::Mod15Write
ST3160021ASL::Mod15Write

So they seem to apply the fix for SG drives only.

Just in case somebody finds this useful...

Eduardo.
