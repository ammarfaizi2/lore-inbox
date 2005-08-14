Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbVHNRCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVHNRCv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 13:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVHNRCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 13:02:51 -0400
Received: from news.cistron.nl ([62.216.30.38]:37353 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S932563AbVHNRCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 13:02:50 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: Re: 2.6.13-rcX really this bad ?
Date: Sun, 14 Aug 2005 17:02:49 +0000 (UTC)
Organization: Cistron
Message-ID: <ddntfp$a6p$1@news.cistron.nl>
References: <ddn5aa$glm$1@news.cistron.nl> <20050814114317.GA1365@localhost.localdomain> <20050814123007.GA647@mipter.zuzino.mipt.ru>
X-Trace: ncc1701.cistron.net 1124038969 10457 62.216.30.70 (14 Aug 2005 17:02:49 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan  <adobriyan@gmail.com> wrote:
>> Is the machine running X? We need some output from it so we can debug
>> what's going on, the info should be printed to the console. It would
>> be great if you could run the latest kernel and see if you get any
>> output. Also add nmi_watchdog=2 to the boot command line.

No, it's not running X. It's running debian (amd64)
I allready posted more details http://newsgate.newsserver.nl/kernel/ 
including problems with SCSI.
_my_ guess it's an IRQ problem (acpi related) ?

>> You can also set up a serial console or netconsole to capture the output
>> from the server with the help of another machine, described in
>> Documentation/serial-console.txt
>> Documentation/networking/netconsole.txt

As stated before, it's connected to a sercon, but not with capture
capabilities. I've a program that captured a few panics/resets

>Danny, could you please go to http://bugme.osdl.org/show_bug.cgi?id=4982
>and fill new info there.

I certainly will!

>Alexander, could you please forward this email to Danny if you don't get
>bounces from him. I got this when tried to reply that his bug was sucked
>into bugzilla.

>     dth@picard.cistron.nl
>Technical details of permanent failure:
>TEMP_FAILURE: Could not initiate SMTP conversation with any hosts:
>[bitbucket.cistron.nl (100): Connection timed out]

Ouch, wil look into this ...

Danny
dth@cistron.nl


