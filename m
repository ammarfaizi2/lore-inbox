Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTIZHuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 03:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbTIZHuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 03:50:15 -0400
Received: from web40903.mail.yahoo.com ([66.218.78.200]:24201 "HELO
	web40903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261305AbTIZHuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 03:50:05 -0400
Message-ID: <20030926075004.79990.qmail@web40903.mail.yahoo.com>
Date: Fri, 26 Sep 2003 00:50:04 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: 2.6.0-test5 broke RPM 4.2 on Red Hat 9 in a VERY weird way
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F7378ED.20409@rackable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Flory,

--- Samuel Flory <sflory@rackable.com> wrote:
> Bradley Chapman wrote:
> > Damn, spoke too soon :(
> > 
> > I upgraded to popt 1.8.1, installed beecrypt (rawhide RPM needs it), and
> installed
> > rpm 4.2.1 from rawhide -- all using LD_ASSUME_KERNEL=2.2.5. Reloaded my konsole
> > to clear&reset my environment.
> > 
> > Now I still get the error, but the program still works, i.e. something like
> this:
> > 
> > rpm -qpl /download/system/popt-1.8.1-0.30.i386.rpm
> > rpmdb: unable to join the environment
> > error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> > error: cannot open Packages index using db3 - Resource temporarily unavailable
> (11)
> > error: cannot open Packages database in /var/lib/rpm
> > warning: /download/system/popt-1.8.1-0.30.i386.rpm: V3 DSA signature: NOKEY, key
> ID
> > 897da07a
> > /usr/include/popt.h
> > /usr/lib/libpopt.a
> > /usr/lib/libpopt.la
> > /usr/lib/libpopt.so
> > /usr/lib/libpopt.so.0
> > /usr/lib/libpopt.so.0.0.0
> > /usr/share/locale/cs/LC_MESSAGES/popt.mo
> > /usr/share/locale/da/LC_MESSAGES/popt.mo
> > /usr/share/locale/de/LC_MESSAGES/popt.mo
> > /usr/share/locale/es/LC_MESSAGES/popt.mo
> > /usr/share/locale/eu_ES/LC_MESSAGES/popt.mo
> > /usr/share/locale/fi/LC_MESSAGES/popt.mo
> > /usr/share/locale/fr/LC_MESSAGES/popt.mo
> > /usr/share/locale/gl/LC_MESSAGES/popt.mo
> > /usr/share/locale/hu/LC_MESSAGES/popt.mo
> > /usr/share/locale/id/LC_MESSAGES/popt.mo
> > /usr/share/locale/is/LC_MESSAGES/popt.mo
> > /usr/share/locale/it/LC_MESSAGES/popt.mo
> > /usr/share/locale/ja/LC_MESSAGES/popt.mo
> > /usr/share/locale/ko/LC_MESSAGES/popt.mo
> > /usr/share/locale/no/LC_MESSAGES/popt.mo
> > /usr/share/locale/pl/LC_MESSAGES/popt.mo
> > /usr/share/locale/pt/LC_MESSAGES/popt.mo
> > /usr/share/locale/pt_BR/LC_MESSAGES/popt.mo
> > /usr/share/locale/ro/LC_MESSAGES/popt.mo
> > /usr/share/locale/ru/LC_MESSAGES/popt.mo
> > /usr/share/locale/sk/LC_MESSAGES/popt.mo
> > /usr/share/locale/sl/LC_MESSAGES/popt.mo
> > /usr/share/locale/sr/LC_MESSAGES/popt.mo
> > /usr/share/locale/sv/LC_MESSAGES/popt.mo
> > /usr/share/locale/tr/LC_MESSAGES/popt.mo
> > /usr/share/locale/uk/LC_MESSAGES/popt.mo
> > /usr/share/locale/wa/LC_MESSAGES/popt.mo
> > /usr/share/locale/zh/LC_MESSAGES/popt.mo
> > /usr/share/locale/zh_CN.GB2312/LC_MESSAGES/popt.mo
> > /usr/share/man/man3/popt.3.gz
> > 
> > Anybody have any other ideas?
> > 
> 
> 
>    Try a "LD_ASSUME_KERNEL=2.2.5 rpm --rebuilddb"?

Excellent! Thanks for the advice; now it works perfectly fine.

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
