Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbTDHHrv (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 03:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263948AbTDHHrv (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 03:47:51 -0400
Received: from mail.scs.ch ([212.254.229.5]:28322 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id S263939AbTDHHrt (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 03:47:49 -0400
Subject: Re: ES1371 on PPC, garbled output
From: Thomas Sailer <sailer@scs.ch>
To: David Brown <dave@codewhore.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030406171007.GA12378@codewhore.org>
References: <20030406171007.GA12378@codewhore.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 08 Apr 2003 09:59:18 +0200
Message-Id: <1049788758.20194.102.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 19:10, David Brown wrote:

> Has anyone had any experience with getting es1371.c working on PPC? I
> get sound, but the high-end of anything I play through /dev/dsp is
> garbled and randomly cuts in and out. The problem doesn't appear on x86.
> 
> Anyone have any ideas?

Check that your application is using little endian byte ordering if it
is 16bit, since es1371 doesn't do native byte ordering, only little
endian. Also, it doesn't support uLaw/ALaw

Tom

