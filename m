Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131726AbRCOR01>; Thu, 15 Mar 2001 12:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131730AbRCOR0R>; Thu, 15 Mar 2001 12:26:17 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:58898 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131726AbRCOR0C>; Thu, 15 Mar 2001 12:26:02 -0500
Date: Thu, 15 Mar 2001 21:38:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Mårten_Wikström <Marten.Wikstrom@framfab.se>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: How to optimize routing performance
In-Reply-To: <15024.53099.41814.716733@robur.slu.se>
Message-ID: <Pine.LNX.4.33.0103152137240.1320-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Robert Olsson wrote:

>  CONFIG_NET_HW_FLOWCONTROL enables kernel code for it. But device
>  drivers has to have support for it. But unfortunely very few drivers
>  has support for it.

Isn't it possible to put something like this in the layer just
above the driver ?

It probably won't work as well as putting it directly in the
driver, but it'll at least keep Linux from collapsing under
really heavy loads ...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

