Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130043AbRB1CZx>; Tue, 27 Feb 2001 21:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130044AbRB1CZo>; Tue, 27 Feb 2001 21:25:44 -0500
Received: from 2-194.cwb-adsl.telepar.net.br ([200.193.161.194]:30192 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S130043AbRB1CZY>; Tue, 27 Feb 2001 21:25:24 -0500
Date: Tue, 27 Feb 2001 21:46:14 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Amit D Chaudhary <amitc@brocade.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mke2fs hangs while running on /dev/loop0 - kernel version 2.4
Message-ID: <20010227214614.A13399@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Amit D Chaudhary <amitc@brocade.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A9C6184.9050802@brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3A9C6184.9050802@brocade.com>; from amitc@brocade.com on Tue, Feb 27, 2001 at 06:25:08PM -0800
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 27, 2001 at 06:25:08PM -0800, Amit D Chaudhary escreveu:
> I am hoping someone knows more about this case. I have a intel pc 
> running linux 2.4 and the last command below hangs and the statements as 
> they are printed. Even kill -9 does not get it to terminate.
> 
> #touch img.test
> #dd if=/dev/zero of=img.test bs=1k count=2000
> 2000+0 records in
> 2000+0 records out
> #losetup /dev/loop0 img.test
> #mke2fs
> 

known bug, try 2.4.2-ac5 (ac6 seems to have some small problems,
Keith seems to have fixed with a patch some moments ago) some friends of
mine said 2.4.2-ac seems to make loop behave, haven't checked

- Arnaldo
