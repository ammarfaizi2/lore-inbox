Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316579AbSGVH7Z>; Mon, 22 Jul 2002 03:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSGVH7Z>; Mon, 22 Jul 2002 03:59:25 -0400
Received: from ti131310a080-0960.bb.online.no ([80.212.19.192]:8976 "HELO
	grimm1.grimstad") by vger.kernel.org with SMTP id <S316579AbSGVH7Z>;
	Mon, 22 Jul 2002 03:59:25 -0400
Date: Mon, 22 Jul 2002 09:54:19 +0200
From: "Nils O. =?ISO-8859-1?Q?Sel=E5sdal" ?= <noselasd@Utel.no>
Message-Id: <200207220754.g6M7sJ429182@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Subject: NFS unlink race?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like there went some patches into 2.5 to fix some nfs unlink races
(http://linux.bkbits.net:8080/linux-2.5/cset@1.681.1.1?nav=index.html|ChangeSet@-1d)
Does this race apply to 2.4 as well? And might that explain why my dbench run on
a nfs mount always fails to clean up some temp files at the end?
--
NOS@Utel.no
