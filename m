Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312459AbSDJGB3>; Wed, 10 Apr 2002 02:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312464AbSDJGB2>; Wed, 10 Apr 2002 02:01:28 -0400
Received: from zero.tech9.net ([209.61.188.187]:48397 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312459AbSDJGB2>;
	Wed, 10 Apr 2002 02:01:28 -0400
Subject: Re: nanosleep
From: Robert Love <rml@tech9.net>
To: mark manning <mark.manning@fastermail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020410055708.9474.qmail@fastermail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Apr 2002 02:01:35 -0400
Message-Id: <1018418496.903.228.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-10 at 01:57, mark manning wrote:
> hrm - im confiused now - how can you do a n NANO second delay when the
> resolution is 10 mili seconds ?

Uh, you can't - that was his point.

You can try, and you will certainly sleep at least that long, but any
time given modulo 10ms is out the door ...

Like I said, check out the high resolution timers project.

	Robert Love


