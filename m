Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSLBUJA>; Mon, 2 Dec 2002 15:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSLBUJA>; Mon, 2 Dec 2002 15:09:00 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:28310 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264963AbSLBUI7>; Mon, 2 Dec 2002 15:08:59 -0500
Date: Mon, 2 Dec 2002 18:16:01 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: =?iso-8859-1?q?Kurt=20Johnson?= <gorydetailz@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: small doubt about fair-scheduler patch
In-Reply-To: <20021202192553.87887.qmail@web13204.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44L.0212021814060.15981-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2002, Kurt Johnson wrote:

> Im using your fair scheduler patch (2.4.19-fairsched),

> Without the fairsched patch, ps output is normal, eg,
> init is always the first process listed,

> Im just wondering, is this
> purely aesthetically or is there something fishy?

The fairsched patch reorders processes on the tasklist so
that the processes of a user all get CPU time alternately.

It's just a cosmetic issue, caused by the fact that procfs
walks that same list to display all the tasks and now that
list can get reordered ...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

