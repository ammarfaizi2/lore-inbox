Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318387AbSGaPJz>; Wed, 31 Jul 2002 11:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318388AbSGaPJz>; Wed, 31 Jul 2002 11:09:55 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:37878 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318387AbSGaPJz>; Wed, 31 Jul 2002 11:09:55 -0400
Subject: Re: 2.4.19-rc3+SMP+VIA-ApolloPro-133T-Spinlock.h-Panic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: damian@kohlfeld.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003301c238a2$807e8d70$c504050a@corp.anobi.com>
References: <003301c238a2$807e8d70$c504050a@corp.anobi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 Jul 2002 17:29:54 +0100
Message-Id: <1028132994.7886.86.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 15:56, damian@kohlfeld.com wrote:
> The kernel is crashing at line 86 of spinlock.h when I run the driver upload
> for a Dialogic Voice Board.  It says In Interrupt Handler - not syncing.
> This is an application which was written for a uniprocessor environment and
> I suspect this to be the issue.  Is there a way to specifically bind an
> application and it's children to a specified cpu?

That is a kernel side crash. Your driver is failing, take it up with
whoever wrote it since Dialogic stuff seems to be binary only.

You might also want to look at the Asterisk wildcard stuff which does
have open source drivers and for a lot of applications can be rather
neat
http://store.yahoo.com/asteriskpbx/noname.html

