Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271373AbRHOTf0>; Wed, 15 Aug 2001 15:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271387AbRHOTfR>; Wed, 15 Aug 2001 15:35:17 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:31504 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S271373AbRHOTfI>; Wed, 15 Aug 2001 15:35:08 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <9lc0ek$l5k$1@ns1.clouddancer.com>
In-Reply-To: <Pine.GSO.4.10.10108131229270.27903-100000@press-gopher.uchicago.edu>    <Pine.LNX.4.33L.0108131451470.6118-100000@imladris.rielhome.conectiva> <20010814220545.D31070@pasky.ji.cz> <Pine.LNX.4.33L.0108131451470.6118-100000@imladris.rielhome.conectiva>;    from riel@conectiva.com.br on Mon, Aug 13, 2001 at 02:55:42PM -0300 <9lc0ek$l5k$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010815193521.4DDE8783F5@mail.clouddancer.com>
Date: Wed, 15 Aug 2001 12:35:21 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>Why we are giving so big importance to root processes? Yes, they are
>important, but they are even more likely to flood our memory, because
>limits don't apply to them. I propose to just divide their badness
>by 2, not by 4.

Gee, lets punish everybody in case of one bad app...


>I also propose to half badness of processes with pid < 1000 - those
>processes are usually also important, because they are called during
>boot-time and they usually handle important system affairs.


The belief that boot started processes remain under a pid < 1000 is
flawed.  Simple example: the postfix mail server.


-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

