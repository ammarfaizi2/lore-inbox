Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262696AbREOJKB>; Tue, 15 May 2001 05:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbREOJJv>; Tue, 15 May 2001 05:09:51 -0400
Received: from AMontpellier-201-1-2-100.abo.wanadoo.fr ([193.253.215.100]:52986
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S262696AbREOJJi>; Tue, 15 May 2001 05:09:38 -0400
Subject: Re: dget()
From: Xavier Bestel <xavier.bestel@free.fr>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Blesson Paul <blessonpaul@usa.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105150919580.1454-100000@penguin.homenet>
In-Reply-To: <Pine.LNX.4.21.0105150919580.1454-100000@penguin.homenet>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 15 May 2001 11:06:47 +0200
Message-Id: <989917611.27689.9.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15 May 2001 09:21:47 +0100, Tigran Aivazian a écrit :
> On 15 May 2001, Blesson Paul wrote:
> >              In everyfile system, dget() function is called. But I cannot find
> > where is the dget() function is written. Where is it
> 
> To find this out, you type:
> 
> # vi -t dget
> 
> and then look at the bottom line which would show
> "./include/linux/dcache.h"
> 
> This assumes you have built the tags by:
> 
> # cd /usr/src/linux
> # find -name '*.[ch]' | ctags -L- &
> # echo "set tags=tags" >> .vimrc

... or:
# cd /usr/src/linux
# make tags

Xav

