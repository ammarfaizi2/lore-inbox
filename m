Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbTFWL3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbTFWL3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:29:12 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:50950 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S266006AbTFWL3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:29:08 -0400
Message-Id: <200306231132.h5NBWVu10803@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: John Bradford <john@grabjohn.com>, felipe_alfaro@linuxmail.org,
       helgehaf@aitel.hist.no
Subject: Re: O(1) scheduler & interactivity improvements
Date: Mon, 23 Jun 2003 14:36:37 +0300
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200306231050.h5NAo8EE000843@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200306231050.h5NAo8EE000843@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 June 2003 13:50, John Bradford wrote:
> > Maybe I have different a different idea of what "interactive" should be.
> 
> [snip]
> 
> > moving windows around the screen do feel jerky and laggy at best
> > when the machine is loaded. For a normal desktop usage, I prefer all
> > my intensive tasks to start releasing more CPU cycles so moving a
> > window around the desktop feels completely smooth
> 
> That's fine for a desktop box, but I wouldn't really want a heavily
> loaded server to have database queries starved just because somebody
> is scrolling through a log file, or moving windows about doing admin
> work.

Well... a heavily loaded database server is typically sit headless
or with monitor turned off. ;)

Scrolling thru log file won't eat much CPU anyway, and if
your database admin do *lots* of window moving on a heavily
loaded database server... may I suggest looking for a better
admin? ;);)

(*lots* defined as "enough to noticeably slow db querires")
--
vda
