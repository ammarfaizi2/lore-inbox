Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTIYXa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTIYXa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:30:27 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:40769 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261156AbTIYXaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:30:25 -0400
Message-ID: <3F7378ED.20409@rackable.com>
Date: Thu, 25 Sep 2003 16:23:25 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bradley Chapman <kakadu_croc@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 broke RPM 4.2 on Red Hat 9 in a VERY weird way
References: <20030925212353.74708.qmail@web40903.mail.yahoo.com>
In-Reply-To: <20030925212353.74708.qmail@web40903.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2003 23:30:24.0597 (UTC) FILETIME=[FEA74050:01C383BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman wrote:
> Damn, spoke too soon :(
> 
> I upgraded to popt 1.8.1, installed beecrypt (rawhide RPM needs it), and installed
> rpm 4.2.1 from rawhide -- all using LD_ASSUME_KERNEL=2.2.5. Reloaded my konsole
> to clear&reset my environment.
> 
> Now I still get the error, but the program still works, i.e. something like this:
> 
> rpm -qpl /download/system/popt-1.8.1-0.30.i386.rpm
> rpmdb: unable to join the environment
> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages index using db3 - Resource temporarily unavailable (11)
> error: cannot open Packages database in /var/lib/rpm
> warning: /download/system/popt-1.8.1-0.30.i386.rpm: V3 DSA signature: NOKEY, key ID
> 897da07a
> /usr/include/popt.h
> /usr/lib/libpopt.a
> /usr/lib/libpopt.la
> /usr/lib/libpopt.so
> /usr/lib/libpopt.so.0
> /usr/lib/libpopt.so.0.0.0
> /usr/share/locale/cs/LC_MESSAGES/popt.mo
> /usr/share/locale/da/LC_MESSAGES/popt.mo
> /usr/share/locale/de/LC_MESSAGES/popt.mo
> /usr/share/locale/es/LC_MESSAGES/popt.mo
> /usr/share/locale/eu_ES/LC_MESSAGES/popt.mo
> /usr/share/locale/fi/LC_MESSAGES/popt.mo
> /usr/share/locale/fr/LC_MESSAGES/popt.mo
> /usr/share/locale/gl/LC_MESSAGES/popt.mo
> /usr/share/locale/hu/LC_MESSAGES/popt.mo
> /usr/share/locale/id/LC_MESSAGES/popt.mo
> /usr/share/locale/is/LC_MESSAGES/popt.mo
> /usr/share/locale/it/LC_MESSAGES/popt.mo
> /usr/share/locale/ja/LC_MESSAGES/popt.mo
> /usr/share/locale/ko/LC_MESSAGES/popt.mo
> /usr/share/locale/no/LC_MESSAGES/popt.mo
> /usr/share/locale/pl/LC_MESSAGES/popt.mo
> /usr/share/locale/pt/LC_MESSAGES/popt.mo
> /usr/share/locale/pt_BR/LC_MESSAGES/popt.mo
> /usr/share/locale/ro/LC_MESSAGES/popt.mo
> /usr/share/locale/ru/LC_MESSAGES/popt.mo
> /usr/share/locale/sk/LC_MESSAGES/popt.mo
> /usr/share/locale/sl/LC_MESSAGES/popt.mo
> /usr/share/locale/sr/LC_MESSAGES/popt.mo
> /usr/share/locale/sv/LC_MESSAGES/popt.mo
> /usr/share/locale/tr/LC_MESSAGES/popt.mo
> /usr/share/locale/uk/LC_MESSAGES/popt.mo
> /usr/share/locale/wa/LC_MESSAGES/popt.mo
> /usr/share/locale/zh/LC_MESSAGES/popt.mo
> /usr/share/locale/zh_CN.GB2312/LC_MESSAGES/popt.mo
> /usr/share/man/man3/popt.3.gz
> 
> Anybody have any other ideas?
> 


   Try a "LD_ASSUME_KERNEL=2.2.5 rpm --rebuilddb"?

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

