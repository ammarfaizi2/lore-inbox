Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbUCLIDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbUCLIDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:03:16 -0500
Received: from hera.kernel.org ([63.209.29.2]:10371 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262010AbUCLIDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:03:15 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: pts bug? and keyboard on kvm
Date: Fri, 12 Mar 2004 08:02:36 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c2rqqs$pnc$1@terminus.zytor.com>
References: <Pine.LNX.4.58.0403111109290.21406@pina-colada.ucf.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1079078556 26349 63.209.29.3 (12 Mar 2004 08:02:36 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 12 Mar 2004 08:02:36 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0403111109290.21406@pina-colada.ucf.ics.uci.edu>
By author:    Edmund Lau <edlau@ucf.ics.uci.edu>
In newsgroup: linux.dev.kernel
> 
> I just upgraded to 2.6.4.  Is it normal for /dev/pts numbers to keep
> increasing now?  With 2.6.3, I could log in or create an xterm and a pts
> would be assigned.  Then when it was released, another process could reuse
> that number.  Now, it seems it just keeps incrementing.  Has this changed?
> 

Yes.  We may make a slight change to this, due to the incredibly
braindamaged way glibc and xterm handles utmp, however.

	-hpa
