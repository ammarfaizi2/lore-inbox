Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTIAFp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 01:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTIAFp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 01:45:28 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:18180
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262577AbTIAFpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 01:45:25 -0400
Subject: Re: [SHED] Questions.
From: Robert Love <rml@tech9.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200309011507.45314.kernel@kolivas.org>
References: <1062324435.9959.56.camel@big.pomac.com>
	 <1062374409.5171.194.camel@big.pomac.com>
	 <1062389038.1313.39.camel@boobies.awol.org>
	 <200309011507.45314.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1062395745.1313.42.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Mon, 01 Sep 2003 01:55:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-01 at 01:07, Con Kolivas wrote:

> I hate to keep butting in and saying this but this is not quite what happens. 
> If a task is considered interactive (a priority boost of 2 or more) and it 
> uses up a full timeslice then it is checked to see if a starvation limit has 
> been exceeded by the tasks on the expired array. If it hasn't exceeded the 
> limit, the interactive task will be rescheduled again ahead of everything 
> else. ie if A is the only task still considered interactive after using up 
> it's timeslice the first time it will go

I know this.  I mentioned earlier what I was saying was ignoring the
interactive task reinsertion optimization.

I am trying to explain things in general.

	Robert Love


