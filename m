Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTDUXcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTDUXcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:32:08 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:50927 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262694AbTDUXcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:32:08 -0400
Date: Mon, 21 Apr 2003 16:39:41 -0700
From: Chris Wright <chris@wirex.com>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: Chris Wright <chris@wirex.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: grsecurity in 2.5?
Message-ID: <20030421163941.E11886@figure1.int.wirex.com>
Mail-Followup-To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	Chris Wright <chris@wirex.com>, lkml <linux-kernel@vger.kernel.org>
References: <20030421212501.GA30266@kroah.com> <Pine.LNX.4.44.0304212335520.25621-100000@server.piarista-kkt.sulinet.hu> <20030421143849.A11883@figure1.int.wirex.com> <1050968186.3065.16.camel@flat41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1050968186.3065.16.camel@flat41>; from gj@pointblue.com.pl on Tue, Apr 22, 2003 at 12:36:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Grzegorz Jaskiewicz (gj@pointblue.com.pl) wrote:

> Maybe we should start to bring them piece by piece, fe. PaX first and
> others. 

PaX is an example of something that won't port to LSM.  The grsecurity
MAC, RBAC, chroot restrictions, TPE are the types of things that would port
nicely.

> Question is not that will somebody do that, i am sure of that - grsec is
> needed in 2.4 - and it will be needed in 2.6. Question is, if it will be
> included in mainstream kernel release ?

I don't expect to see it in 2.6 mainline at all.  The patch could be
reduced if some of the core access control logic was placed in an LSM.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
