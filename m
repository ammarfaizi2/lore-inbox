Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315264AbSDWRQQ>; Tue, 23 Apr 2002 13:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSDWRQP>; Tue, 23 Apr 2002 13:16:15 -0400
Received: from zero.tech9.net ([209.61.188.187]:9234 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S315264AbSDWRQN>;
	Tue, 23 Apr 2002 13:16:13 -0400
Subject: Re: exporting task_nice in O(1)-sched
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020423152749.GC1697@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 23 Apr 2002 13:15:45 -0400
Message-Id: <1019582164.1465.110.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-23 at 11:27, J.A. Magallon wrote:
 
> Found this building bproc. New O(1) scheduler kills the nice field in
> task struct. It gives a way to fix the niceness (set_user_nice()), but
> the funtion to _query_ is not exported. Any particular reason ?

Probably because Ingo intended to hide as many interfaces to the
scheduler as possible and only export those symbols that were needed.

It is safe to export if it is needed.

	Robert Love

