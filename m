Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319104AbSIJMhv>; Tue, 10 Sep 2002 08:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319105AbSIJMhv>; Tue, 10 Sep 2002 08:37:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35839 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319104AbSIJMhv>; Tue, 10 Sep 2002 08:37:51 -0400
Date: Tue, 10 Sep 2002 14:42:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andreas Kerl <andreas.kerl@dts.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: compile error 2.4.20.pre5-ac4 
In-Reply-To: <3D7D0D02.6060604@dts.de>
Message-ID: <Pine.NEB.4.44.0209101441300.7966-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Andreas Kerl wrote:

> drivers/ide/idedriver.o: In function `proc_ide_read_drivers':
> drivers/ide/idedriver.o(.text+0x4c9): undefined reference to `ide_modules'
>...

Hi Andreas,

thanks for the report. This is a known issue when compiling
2.4.20-pre5-ac4 without IDE support. A workaround is to enable IDE
support.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

