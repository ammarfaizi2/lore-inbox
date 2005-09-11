Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVIKOTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVIKOTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 10:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVIKOTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 10:19:18 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:44127 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932221AbVIKOTS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 10:19:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L/Y/f6kQe5ELDX9bzdR4MO70Z08stakOZ2frSo/lFjufDNvEU7D2aUnWJ0d2WwKClEW7P4bKp5wcOwkYmNnCRTNVbCwXg0xmh8rmkfPYH218atCMpLExd73AQWXUvRcZ0kVNrmGM1+4GYSRBDUt1cGbNM6Xw2rNxTpM/IPjAHAQ=
Message-ID: <6cf16f1305091107197130534a@mail.gmail.com>
Date: Sun, 11 Sep 2005 10:19:17 -0400
From: kpowerinfinity <kpowerinfinity@gmail.com>
Reply-To: kpowerinfinity@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Compilation error -- UML on 2.6.13.1
In-Reply-To: <6cf16f1305091107172d3e9db6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6cf16f1305091106542283377b@mail.gmail.com>
	 <6cf16f1305091107172d3e9db6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am unable to compile UML on 2.6.13.1. It exits with the following error:

  CC      arch/um/sys-i386/unmap.o
  LD      arch/um/sys-i386/unmap_fin.o
ld: cannot open libc.a: No such file or directory
make[1]: *** [arch/um/sys-i386/unmap_fin.o] Error 1
make: *** [arch/um/sys-i386] Error 2

I got this error while doing "make linux ARCH=um"
Pls help.

rgds,
KK Mehra
