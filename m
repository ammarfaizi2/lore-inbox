Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275951AbTHONfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 09:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275953AbTHONfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 09:35:48 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:42950 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S275951AbTHONfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 09:35:44 -0400
Date: Fri, 15 Aug 2003 15:35:41 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs corruption with 2.6.0-test
Message-ID: <20030815133541.GA31286@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030814221411.GA3916@k3.hellgate.ch> <20030815122616.GA20765@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815122616.GA20765@namesys.com>
X-Operating-System: Linux 2.6.0-test3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003 16:26:16 +0400, Oleg Drokin wrote:
> > Both 2.6.0-test3 and -test2 produced kernel NULL pointer dereferences with
> > those files. fsck found the corruption fixable. Works again now.
> 
> What was the problem reported by reiserfsck?

Uh oh. Didn't take notes. IIRC it reported "too many blocks" for a number
of files, and fixed them by cutting each back to one block.

Roger
