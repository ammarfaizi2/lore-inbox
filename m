Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271437AbRHOUvr>; Wed, 15 Aug 2001 16:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271439AbRHOUvh>; Wed, 15 Aug 2001 16:51:37 -0400
Received: from mail.erisksecurity.com ([208.179.59.234]:14914 "EHLO
	Tidal.eRiskSecurity.com") by vger.kernel.org with ESMTP
	id <S271438AbRHOUvZ>; Wed, 15 Aug 2001 16:51:25 -0400
Message-ID: <3B7AE0D6.2090804@erisksecurity.com>
Date: Wed, 15 Aug 2001 16:51:34 -0400
From: David Ford <david@erisksecurity.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010815
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <Pine.GSO.4.10.10108131229270.27903-100000@press-gopher.uchicago.edu>    <Pine.LNX.4.33L.0108131451470.6118-100000@imladris.rielhome.conectiva> <20010814220545.D31070@pasky.ji.cz> <Pine.LNX.4.33L.0108131451470.6118-100000@imladris.rielhome.conectiva>;    from riel@conectiva.com.br on Mon, Aug 13, 2001 at 02:55:42PM -0300 <9lc0ek$l5k$1@ns1.clouddancer.com> <20010815193521.4DDE8783F5@mail.clouddancer.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also consider that many places use randomized pids. You can only assume 
a few things about pids and that has to be done by evaluating kernel 
threads and the init pid.

David

Colonel wrote:

>>I also propose to half badness of processes with pid < 1000 - those
>>processes are usually also important, because they are called during
>>boot-time and they usually handle important system affairs.
>>
>
>The belief that boot started processes remain under a pid < 1000 is
>flawed.  Simple example: the postfix mail server.
>


