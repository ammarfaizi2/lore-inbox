Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266706AbRGKOd3>; Wed, 11 Jul 2001 10:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbRGKOdT>; Wed, 11 Jul 2001 10:33:19 -0400
Received: from babel.spoiled.org ([212.84.234.227]:9058 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S266706AbRGKOdK>;
	Wed, 11 Jul 2001 10:33:10 -0400
Date: 11 Jul 2001 14:33:10 -0000
Message-ID: <20010711143310.26965.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: ionut@cs.columbia.edu (Ion Badulescu)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire net driver update
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0107100932230.13462-100000@age.cs.columbia.edu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote:
> Hi,
> 
> This patch fixes two real problems: missing initialization of a register 
> which broke 100mbit half-duplex, and dereferencing of freed memory. It 
> also massages the whitespace a bit.

This patch breaks my starfire totally:

With 2.4.6 on a 100Mbit HUB (100fx-HD) it receives but seems to have problems
to send.
It worked with 2.4.6-pre5.
With 2.4.6 and your patch I get the following immediately:
kernel: NETDEV WATCHDOG: eth5: transmit timed out
kernel: eth5: Transmit timed out, status 00000000, resetting...
kernel: 0c011 0730c811 0730b011 0730b811 0730a011 0730a811 07309011 07309811 07308011 07308811 07307011 07307811 07306011 07306811 07305011 07305811 07304011 07304811 07303011 07303811 07301011 07301811 07300011 07300811 072ff011 072ff811 072fe011 072fe811 072fd011 072fd811 072fc011 072fc811 072fb011 072fb811 072fa011 072fa811 072f9011 072f9811 072f8011 072f8811 072f7011 072f7811 072f6011 072f6811 072f4011 072f4811 072f3011 072f3811 072f2011 072f2811 072f1011 072f1811 072f0011 072f0811 072ef011 072ef811 072ee011 072ee811 072ed011 072ed811 072ec011 072ec811 072eb011 072eb811 072ea011 072ea811 072e9011 072e9811 072e7011 072e7811 072e6011 072e6811 072e5011 072e5811 072e4011 072e4811 072e3011 072e3811 072e2011 072e2811 072e1011 072e1811 072e0011 072e0811 072df011 072df811 072de011 072de811 072dd011 072dd811 072dc011 072dc811 072da011 072da811 072d9011 072d9811 072d8011 072d8811 072d7011 072d7811 072d6011 072d6811 072d5011 072d5811 072d4011 072d4811 072d3011 072d3811 072d2011 072d2811 072d1011
nel: d1811 072d0011 072d0811 072cf011 072cf811 072cd011 072cd811 072cc011 072cc811 072cb011 072cb811 072ca011 072ca811 072c9011 072c9811 072c8011 072c8811 072c7011 072c7811 072c6011 072c6811 072c5011 072c5811 072c4011 072c4811 072c3011 072c3811 072c2011 072c2811 072c0011 072c0811 072bf011 072bf811 072be011 072be811 072bd011 072bd813

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

