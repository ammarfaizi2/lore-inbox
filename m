Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271636AbRICIph>; Mon, 3 Sep 2001 04:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271651AbRICIp1>; Mon, 3 Sep 2001 04:45:27 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:15367 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271636AbRICIpQ>;
	Mon, 3 Sep 2001 04:45:16 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Samium Gromoff <_deepfire@mail.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: first fruits 
In-Reply-To: Your message of "Mon, 03 Sep 2001 12:53:46 GMT."
             <200109031253.f83CrlK26536@vegae.deep.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Sep 2001 18:45:29 +1000
Message-ID: <21931.999506729@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001 12:53:46 +0000 (UTC), 
Samium Gromoff <_deepfire@mail.ru> wrote:
>          Hello folks, here are first fruits.
>    One problem with it: i`m not that sure that Keith`s .config generator
>  wasnt wrong here - "unknown architecture" sounds verly much like it...
>epson1355fb.c:73: #error unknown architecture

CML1 is wrong.  It lets anybody select epson1355fb, but the code
requires CONFIG_SUPERH.  Guess why my .force_default has epson1355fb
forced off?  Tell the epson1355fb maintainer to fix drivers/video/Config.in
and move on.

