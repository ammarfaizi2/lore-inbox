Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSHLOo1>; Mon, 12 Aug 2002 10:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318067AbSHLOo0>; Mon, 12 Aug 2002 10:44:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51618 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318065AbSHLOnx>; Mon, 12 Aug 2002 10:43:53 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Paul Larson <plars@austin.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hubertus Franke <frankeh@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
       andrea@suse.de, Dave Jones <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0208091459010.1283-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0208091459010.1283-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Aug 2002 09:40:27 -0500
Message-Id: <1029163233.22405.381.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken had a patch a while back that should probably be
considered with all this too. 
http://marc.theaimsgroup.com/?l=linux-kernel&m=100506843702466&w=2

This fixes the calculation of the max number of tasks so that it doesn't
consider highmem since it can't use use that anyway.

-Paul Larson

