Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWA0Jby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWA0Jby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 04:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWA0Jby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 04:31:54 -0500
Received: from pproxy.gmail.com ([64.233.166.183]:56324 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932440AbWA0Jbx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 04:31:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n48bNUelVRpwz9pNlX0fODlIYnmvmqvkWIzT7u4/+FvgLbh3EIkIwikJSWYGWS+Z+eQUJzK+tgxeeRqoo5WX6eiHMC7J3gYofx90RYC8kk1qCciRVMHtIXhmQGdAkSlGOz7Md2X+5nKdcZWK+bT7KiEZSgQcTDFgcoMPPz0IKrA=
Message-ID: <aed62bae0601270131t3143753ci10df3d48e81ebc59@mail.gmail.com>
Date: Fri, 27 Jan 2006 15:01:52 +0530
From: sarat <saratkumar.koduri@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hai.. we compiled and installed the 2.6.10 kernel and we selected the
loadable kernel modules options and nothing else.. so far it was fine
installed and running.. but today i got a firewall module program..
and when we tried to compile it gave warnings like..

********************************************************************************************
[root@localhost newfire]# make -C /var/linux-2.6.10/ SUBDIRS=$PWD modules
make: Entering directory `/var/linux-2.6.10'
  CC [M]  /var/sarat/newfire/firewall.o
/var/sarat/newfire/firewall.c:53: warning: initialization from
incompatible poin ter type
/var/sarat/newfire/firewall.c:53: warning: initialization from
incompatible poin ter type
/var/sarat/newfire/firewall.c:53: warning: initialization from
incompatible poin ter type
  Building modules, stage 2.
  MODPOST
*** Warning: "unregister_firewall" [/var/sarat/newfire/firewall.ko] undefined!
*** Warning: "register_firewall" [/var/sarat/newfire/firewall.ko] undefined!
  CC      /var/sarat/newfire/firewall.mod.o
  LD [M]  /var/sarat/newfire/firewall.ko
make: Leaving directory `/var/linux-2.6.10'
********************************************************************************************

and when we try to insert into kernel it says...

********************************************************************************************
[root@localhost newfire]# insmod firewall.ko
insmod: error inserting 'firewall.ko': -1 Invalid module format
********************************************************************************************

i tried google also but invain.. so plzz help me....

urs sarat
