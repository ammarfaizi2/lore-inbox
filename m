Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSIIR7H>; Mon, 9 Sep 2002 13:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSIIR7H>; Mon, 9 Sep 2002 13:59:07 -0400
Received: from p5088746E.dip.t-dialin.net ([80.136.116.110]:36768 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317597AbSIIR7G>; Mon, 9 Sep 2002 13:59:06 -0400
Date: Mon, 9 Sep 2002 12:03:12 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
cc: Joe Kellner <jdk@kingsmeadefarm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: clean before or after dep?
In-Reply-To: <20020908135306.GB701@gallifrey>
Message-ID: <Pine.LNX.4.44.0209091201420.3793-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 8 Sep 2002, Dr. David Alan Gilbert wrote:
> I always do
> 
> make clean && make dep && make ......

I use to do:

# make menuconfig
# make clean dep vmlinuz modules
# su -c "make modules_install"
# install-kernel.sh

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

