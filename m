Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVJGOam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVJGOam (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbVJGOal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:30:41 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:21151 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S964874AbVJGOai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:30:38 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 'Undeleting' an open file
Date: Fri, 7 Oct 2005 14:30:37 +0000 (UTC)
Organization: Cistron
Message-ID: <di60qd$sbp$1@news.cistron.nl>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <43442D19.4050005@perkel.com> <Pine.LNX.4.58.0510052208130.4308@be1.lrz> <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1128695437 29049 194.109.0.112 (7 Oct 2005 14:30:37 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@zahadum.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>,
Giuseppe Bilotta  <bilotta78@hotpop.com> wrote:
>On Wed, 5 Oct 2005 23:05:34 +0200 (CEST), Bodo Eggert wrote:
>
>> Files are deleted if the last reference is gone. If you play a music file
>> and unlink it while it's playing, it won't be deleted untill the player
>> closes the file, since an open filehandle is a reference.
>
>BTW, I've always wondered: is there a way to un-unlink such a file?

Around 2.4.15 we had the same discussion here - see for example
http://www.ussg.iu.edu/hypermail/linux/kernel/0201.2/0881.html
(but be sure to read the whole thread).

Mike.

