Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131697AbRBMPHw>; Tue, 13 Feb 2001 10:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131711AbRBMPHn>; Tue, 13 Feb 2001 10:07:43 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:15344 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131697AbRBMPHe>; Tue, 13 Feb 2001 10:07:34 -0500
Date: Tue, 13 Feb 2001 11:26:04 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Thomas Foerster <puckwork@madz.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to install Alan's patches?
Message-ID: <20010213112604.H1256@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Thomas Foerster <puckwork@madz.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20010213150328Z131694-514+4497@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010213150328Z131694-514+4497@vger.kernel.org>; from puckwork@madz.net on Tue, Feb 13, 2001 at 04:03:02PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 13, 2001 at 04:03:02PM +0100, Thomas Foerster escreveu:
> Hi folks,
> 
> sorry for the silly question, but i can't get it to work :
> 
> I have linux-2.4.1 unpacked, configured and installed.
> Now i want to apply Alan Cox patche (linux-2.4.1-ac9), but i always get
> these errors :
> 
> [root@space src]# cat /home/puck/patch-2.4.1-ac9 | patch -p0
> can't find file to patch at input line 4
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:

cd src/linux
cat /home/puck/patch-2.4.1-ac9 | patch -p1
                                         ^
                                         |

- Arnaldo
