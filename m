Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263324AbUEPHs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUEPHs7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 03:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUEPHs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 03:48:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:44244 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263324AbUEPHs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 03:48:58 -0400
Date: Sun, 16 May 2004 00:48:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: FabF <Fabian.Frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RE :[BUG 2.6.6mm2] bk-input is broken on AMD
Message-Id: <20040516004827.2aa29096.akpm@osdl.org>
In-Reply-To: <1084527815.6644.2.camel@bluerhyme.real3>
References: <1084527815.6644.2.camel@bluerhyme.real3>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <Fabian.Frederick@skynet.be> wrote:
>
> Hi,
> 
> 	No response for that thread...Whose the right person to ctx for problem
> in bk-input ? No one noticed the same problem (keyboard non-functionning
> with bk-input in mm2) ?

An AT keyboard on x86_64 works for me.  Are there any bad-looking messages
in the dmesg output?

Try doing

-#undef DEBUG
+#define DEBUG

in i8042.c and send the resulting output?

