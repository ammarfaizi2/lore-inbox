Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUG0CqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUG0CqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 22:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUG0CqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 22:46:21 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:989 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266224AbUG0Cp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 22:45:57 -0400
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <20040725173652.274dcac6.akpm@osdl.org> <cone.1090802581.972906.20693.502@pc.kolivas.org> <20040726202946.GD26075@ca-server1.us.oracle.com> <20040726134258.37531648.akpm@osdl.org> <cone.1090882721.156452.20693.502@pc.kolivas.org> <4105A761.9090905@tequila.co.jp> <20040726180943.4c871e4f.akpm@osdl.org> <4105AD1C.2050507@tequila.co.jp> <slrn-0.9.7.4-15175-21673-200407271159-tc@hexane.ssi.swin.edu.au>
Message-ID: <cone.1090896213.276247.20693.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Tim Connors <tconnors+linuxkernel1090893567@astro.swin.edu.au>
Cc: Clemens Schwaighofer <cs@tequila.co.jp>, Andrew Morton <akpm@osdl.org>,
       Joel.Becker@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Date: Tue, 27 Jul 2004 12:43:33 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors writes:

> Clemens Schwaighofer <cs@tequila.co.jp> said on Tue, 27 Jul 2004 10:17:16 +0900:
>> 
>> Andrew Morton wrote:
>> | Clemens Schwaighofer <cs@tequila.co.jp> wrote:
>> 
>> |>
>> |>I changed that to 20 now, but I don't know if this will make things
>> |>worse or better.
>> |
>> | It may appear to be better, but you now have 100, maybe 200 megabytes less
>> | pagecache available across the entire working day.
>> 
>> which might slow down overall working speed? or responsness of programs?
> 
> Depends on what you do. Do you compile kernels regularly? In
> particular, do you have to wait for them, or do you just let them sit
> in the background, and come back to them when you rememeber, since
> you've been busy doing real work for the past 5 hours? If you wait,
> then I guess you want high swapiness.

Well I'm tired of this discussion which comes up every month or so and I 
brought it up! Clearly my patch is not considered adequate so I promise 
never to bring it up again.

Cheers,
Con

