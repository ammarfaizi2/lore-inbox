Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285087AbRLQKPT>; Mon, 17 Dec 2001 05:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285088AbRLQKPJ>; Mon, 17 Dec 2001 05:15:09 -0500
Received: from [210.176.202.14] ([210.176.202.14]:21412 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S285087AbRLQKOw>; Mon, 17 Dec 2001 05:14:52 -0500
Subject: compling kernel module against different kernel settings.
From: Joe Wong <joewong@rcn.com.hk>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Dec 2001 18:14:48 +0800
Message-Id: <1008584088.9648.0.camel@star4.planet.rcn.com.hk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I am quite new to linux kernel build procedure and please forgive me
if my question is too _easy_.

  From what I know I can change different parameters to build kernel by
make xconfig/make menuconfig/make config.

  The above proesses will generate different settings in .config and
autoconf.h. Now I want to build my loadable kernel module against
different kernel settings ( like CPU type, SMP support or not and so..
). Is this possible to automate all of the steps involed?

  I found out that 'make dep' does not update *.ver in
./include/linux/modules/ and I have to use make mrproper but it will
delete everthing..

  Or, I should build a generic module that can run on different kernel
settings? I am quite confuse and hope someone can give me a hand on
this.

TIA.

- Joe






