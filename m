Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbUAWJku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUAWJii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:38:38 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:33436 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266556AbUAWJhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:37:41 -0500
Subject: Re: 2.6.2-rc1-mm1 oops with X
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: glennpj@charter.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040123011158.665ad574.akpm@osdl.org>
References: <20040123061927.GA7025@gforce.johnson.home>
	 <20040122231814.149c8e8d.akpm@osdl.org>
	 <1074848612.23073.81.camel@imladris.demon.co.uk>
	 <20040123011158.665ad574.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074850572.23073.83.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 23 Jan 2004 09:36:12 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 01:11 -0800, Andrew Morton wrote:
> > This is what GDB watchpoints were invented for, surely? 
> 
> I suppose that might help.  But for me the bug triggered towards the end of
> initscripts (it moves around) after we've been through that code path a
> zillion times.  It probably needs to be solved by inspection.  If one can
> get it to happen reliably.

Can't you script it just to automatically show a backtrace and continue,
then peruse the logs later?

-- 
dwmw2


