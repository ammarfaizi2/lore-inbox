Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTEIMDO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTEIMDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:03:13 -0400
Received: from pop.gmx.net ([213.165.64.20]:18222 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262486AbTEIMCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:02:52 -0400
Message-ID: <3EBB9BD4.8070101@gmx.net>
Date: Fri, 09 May 2003 14:15:16 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem: strace -ff fails on 2.4.21-rc1
References: <200305090513_MC3-1-3814-65C7@compuserve.com>
In-Reply-To: <200305090513_MC3-1-3814-65C7@compuserve.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> Ingo Oeser wrote:
> 
> 
>>SUID binaries cannot be ptrace()d under Linux for security reasons.
> 
> 
>   I just found out minicom is spawing /sbin/lockdev which is setgrp
> 'lock'.  Would that cause ptrace failure??

AFAIK that could have caused the failure. Please test 2.4.21-rc2 whcih
has fixes for many ptrace problems.


Carl-Daniel
-- 
http://www.hailfinger.org/

