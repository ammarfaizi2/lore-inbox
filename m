Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265281AbUFHSYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbUFHSYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 14:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbUFHSYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 14:24:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:10899 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265278AbUFHSYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 14:24:32 -0400
Date: Tue, 8 Jun 2004 11:24:30 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: bridge@osdl.org
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] bridge-utils-1.0.4
Message-Id: <20040608112430.794f7fcf@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Released a new version of bridge utilities that supports both new 2.6.7
interface and older 2.6/2.4 releases.  The only changes since 1.0 were
internal to fix compatibility issues. 

The tarball can be downloaded from:
	http://prdownloads.sourceforge.net/bridge


Getting full functionality requires a build system with:
	- libsysfs from the sysfsutils package 
	  http://linux-diag.sourceforge.net/Sysfsutils.html
	- kernel (and headers) from 2.6.7-rc1 or later

Note: libsysfs has not been fully integrated by the main linux vendors.
So producing a full functional package is not possible with the default spec 
file.

The utilities will build (and run) on earlier systems it will just default to 
the old interface and which doesn't have 32/64 bit compatibility.
