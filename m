Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTJKCa5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 22:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbTJKCa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 22:30:57 -0400
Received: from smtp.terra.es ([213.4.129.129]:31896 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S263228AbTJKCa4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 22:30:56 -0400
Date: Sat, 11 Oct 2003 04:30:53 +0200
From: --- <grundig@teleline.es>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: [2.7 "thoughts"] V0.3
Message-Id: <20031011043053.1dba87e7.grundig@teleline.es>
In-Reply-To: <20031011021307.GH727@holomorphy.com>
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
	<20031011040435.299bd3bc.grundig@teleline.es>
	<20031011021307.GH727@holomorphy.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 10 Oct 2003 19:13:07 -0700 William Lee Irwin III <wli@holomorphy.com> escribió:

> cdrecord doesn't make sense because it requires privilege for device
> access anyway.

Yes; thats can be fixed easily adding the ser to some group like this:
brw-rw----    1 root     cdrom     22,   0 2003-05-23 16:41 /dev/cd-rw
but no, cdrecord isn't a good example ;( and I can't think of other users
right now; so I guess the effort isn't worth of it...

Diego Calleja
