Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271587AbTGQWbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 18:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271618AbTGQW3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 18:29:50 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:15803 "HELO
	develer.com") by vger.kernel.org with SMTP id S271601AbTGQW3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 18:29:14 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Andrew Morton <akpm@osdl.org>
Subject: Re: do_div64 generic
Date: Fri, 18 Jul 2003 00:43:58 +0200
User-Agent: KMail/1.5.9
Cc: george@mvista.com, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org
References: <3F1360F4.2040602@mvista.com> <200307172310.48918.bernie@develer.com> <20030717141608.5f1b7710.akpm@osdl.org>
In-Reply-To: <20030717141608.5f1b7710.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307180043.58901.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 July 2003 23:16, Andrew Morton wrote:
> Bernardo Innocenti <bernie@develer.com> wrote:
> > 2) replace all uses of div_long_long_rem() (I see onlt 4 of them in
> >    2.6.0-test1) with do_div(). This is slightly less efficient, but
> >    easier to maintain in the long term.
>
> Ths one's OK by me.  Let's just fix the bug with minimum risk and churn.

Ok, I will be preparing a patch tomorrow unless there are more objections.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


