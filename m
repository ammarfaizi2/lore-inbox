Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTEMU6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbTEMU6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:58:20 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:30603 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261887AbTEMU6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:58:19 -0400
Message-Id: <200305132110.h4DLAkT02067@owlet.beaverton.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Clemens Schwaighofer <cs@tequila.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: Missing disc io stats in /proc/stat in 2.5.69? 
In-reply-to: Your message of "Tue, 13 May 2003 11:27:53 PDT."
             <20030513112753.7612dabd.rddunlap@osdl.org> 
Date: Tue, 13 May 2003 14:10:46 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On Tue, 13 May 2003 16:47:15 +0900 Clemens Schwaighofer <cs@tequila.co.jp> wrote:
    
    | just a more general question. Did the Disc IO stats disappear from
    | /proc/stat in 2.5.69? Or do I have to activated them somehow?
    
    They should show up under /sys/block/<dev> (after mounting
    sysfs on /sys).
    
    Rick, were you working on some docs for this?
    or are some already available?

I was working at something for Documentation/ describing the fields,
but disk I/O stats disappeared from /proc/stat quite a while ago --
basically at the same time they appeared in sysfs.

Since apparently the interest in this trivia :) continues, I'll bump the
priority and submit a file for Documentation/ by the end of the week.
Clemens, if your need is urgent, drop me a line and I can send you a
less polished description sooner.

Rick
