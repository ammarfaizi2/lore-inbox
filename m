Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318196AbSHSHZd>; Mon, 19 Aug 2002 03:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318198AbSHSHZd>; Mon, 19 Aug 2002 03:25:33 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:6830 "EHLO
	completely") by vger.kernel.org with ESMTP id <S318196AbSHSHZc>;
	Mon, 19 Aug 2002 03:25:32 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "louie miranda" <louie@chikka.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: *Challenge* Finding a solution (When kernel boots it does not display any system info)
Date: Mon, 19 Aug 2002 00:30:42 -0700
User-Agent: KMail/1.4.6
References: <20020818021522.GA21643@waste.org> <20020819054359.GB26519@think.thunk.org> <02bc01c24746$9d08d600$0300000a@nocpc2>
In-Reply-To: <02bc01c24746$9d08d600$0300000a@nocpc2>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208190030.48180.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August (!)&18, 2002 23:06, louie miranda wrote:
> Is there a patch or any configuration's, info*.
> When the kernel boots.. it just display only the Lilo, etc. a few lines
> after lilo.. and just pauses for a while and after a few seconds
> display the login prompt?
>
> I've seen this once!, but i can't remember where...
Passing "quiet" on the kernel command line, ie append="quiet" in lilo.conf, 
turns off the kernel boot messages. You'll still have to find a way to get 
init and your initscripts to shut up, though.

-Ryan
