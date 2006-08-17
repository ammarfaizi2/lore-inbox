Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWHQWl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWHQWl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWHQWl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:41:28 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:44783 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030295AbWHQWl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:41:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IaEcHL+NQXm+8P057mD4kUp02Tt6ndojOiHDch/iVzJcFldwR3hPdmzxbXOJ7bHf/7nT4hBuyO+2BJNwWk+uz2vOL7fgL9vQt3VeC5IjVGugY4Yvh9RgxcBQjGE+45nRRjlUDRtacxcElKaEXz88l7d0KE9JjIzxfCeRE1dVxnA=
Message-ID: <a44ae5cd0608171541tf2f125dl586f56da6f1b2a41@mail.gmail.com>
Date: Thu, 17 Aug 2006 15:41:27 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "akpm@osdl.org" <akpm@osdl.org>
Subject: 2.6.18-rc4-mm1 + hotfix -- Many processes use the sysctl system call
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My installation of Ubuntu is having trouble with my kernel build
because I disabled support for sysctl:

warning: process `ls' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call
warning: process `evms_activate' used the removed sysctl system call
warning: process `alsactl' used the removed sysctl system call

I am curious whether the use of sysctl indicates a problem in these
processes.  What is the benefit of offering disabling sysctl support?

Thanks,
        Miles
