Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbTEFONZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbTEFOMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:12:24 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7568 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263735AbTEFOLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:11:18 -0400
Subject: Re: The disappearing sys_call_table export.
From: "David S. Miller" <davem@redhat.com>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: D.A.Fedorov@inp.nsk.su, terje.eggestad@scali.com,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0305061133290.2977-100000@marcellos.corky.net>
References: <Pine.LNX.4.44.0305061133290.2977-100000@marcellos.corky.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052212504.983.16.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 02:15:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 01:45, Yoav Weiss wrote:
> In fact, in linux which is opensource, you can probably write a script
> that extracts any unexported symbol from the source code, find a path to
> it from some exported symbol, and automagically create a module that
> re-exports this symbol for your legacy driver to use.

You might have a derivative work after obtaining access to a
non-exported interface.  If this is correct, binary-only modules
can't do this and therefore they must stick to exported interfaces.

-- 
David S. Miller <davem@redhat.com>
