Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268083AbTAJAuS>; Thu, 9 Jan 2003 19:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268084AbTAJAuS>; Thu, 9 Jan 2003 19:50:18 -0500
Received: from windsormachine.com ([206.48.122.28]:23051 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S268083AbTAJAuR>; Thu, 9 Jan 2003 19:50:17 -0500
Date: Thu, 9 Jan 2003 19:58:46 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: John Bradford <john@grabjohn.com>
cc: <jamesclv@us.ibm.com>, <lunz@falooley.org>, <linux-kernel@vger.kernel.org>
Subject: Re: detecting hyperthreading in linux 2.4.19
In-Reply-To: <200301092154.h09Ls5SX005123@darkstar.example.net>
Message-ID: <Pine.LNX.4.33.0301091956550.32077-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, John Bradford wrote:

> If /proc/interrupts shows a processor is handling interrupts then it
> is definitely a 'real' one.  If it isn't handling interrupts, it may
> or may not be a 'real' one.  That's another unreliable and kludgey way
> to tell the difference :-).

What about something like lmsensors?  Wouldn't the motherboard normally
report different temperatures for each cpu, since each has its own temp
diode?

(this originally was supposed to be a in-jest idea to run two threads and
see if one cpu or two cpu's heat up, but then i realized you might as well
just count the temperature diodes :D)

Mike

