Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUHOROH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUHOROH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUHOROH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:14:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:65413 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266189AbUHOROE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:14:04 -0400
Date: Sun, 15 Aug 2004 19:13:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: bunk@fs.tum.de, johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
In-Reply-To: <20040813100040.3fce00db.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.61.0408151907540.12687@scrub.home>
References: <20040813101717.GS13377@fs.tum.de> <Pine.LNX.4.58.0408131231480.20635@scrub.home>
 <1092394019.12729.441.camel@uganda> <Pine.LNX.4.58.0408131253000.20634@scrub.home>
 <20040813110137.GY13377@fs.tum.de> <Pine.LNX.4.58.0408131312390.20634@scrub.home>
 <20040813100040.3fce00db.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Aug 2004, Randy.Dunlap wrote:

> | Abusing select is really the wrong answer. What is needed is an improved 
> | user interface, which allows to search through the kconfig information or 
> | even can match hardware information to a driver and aids the user in 
> | selecting the required dependencies.
> 
> Nice idea.  So are there places where SELECT is the right thing to do,
> i.e., it's required?  (examples, please)

Select should be used for utility functions like CRC32, which often don't 
need their own prompt (except where some external module might need it, 
and a "default m" might suffice here).

bye, Roman
