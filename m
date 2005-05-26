Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVEZJDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVEZJDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 05:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVEZJDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 05:03:07 -0400
Received: from gate.corvil.net ([213.94.219.177]:41224 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261294AbVEZJCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 05:02:52 -0400
Message-ID: <429590AA.8080505@draigBrady.com>
Date: Thu, 26 May 2005 10:02:34 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: proper API for sched_setaffinity ?
References: <4294BAD8.4030300@nortel.com>
In-Reply-To: <4294BAD8.4030300@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> On my system (Mandrake 10.0) the man page for sched_setaffinity() lists 
> the prototype as:
> 
> int  sched_setaffinity(pid_t  pid,  unsigned  int  len,  unsigned  long
>        *mask);
> 
> 
> But /usr/include/sched.h gives it as
> 
> extern int sched_setaffinity (__pid_t __pid, __const cpu_set_t *__mask)
> 
> Which is correct?

The sched_setaffinity interface really is very messy:
http://mail.linux.ie/pipermail/ilug/2004-November/019784.html
API changes in same minor version of glibc should just not happen.

-- 
Pádraig Brady - http://www.pixelbeat.org
--
