Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbUCYBpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 20:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUCYBpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 20:45:22 -0500
Received: from alt.aurema.com ([203.217.18.57]:62114 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263098AbUCYBpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 20:45:18 -0500
Message-ID: <406239AB.6060202@aurema.com>
Date: Thu, 25 Mar 2004 12:45:15 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RPM failures when using 2.6.X kernels on RH9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When attempting to install RPM packages on RH9 using any 2.6.X kernel I 
get the following error messages:

[peterw@mudlark KERNELS]$ sudo rpm -i 
/home/peterw/Downloads/atrpms-29-1.rh9.at.noarch.rpm
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages index using db3 - Resource temporarily 
unavailable (11)
error: cannot open Packages database in /var/lib/rpm
warning: /home/peterw/Downloads/atrpms-29-1.rh9.at.noarch.rpm: V3 DSA 
signature: NOKEY, key ID 66534c2b
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages database in /var/lib/rpm
[peterw@mudlark KERNELS]$

If I revert to a 2.4.X kernel the package installs without any problems.

Can anyone enlighten me to a likely cause for this phenomenon?

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

