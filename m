Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSBMNsT>; Wed, 13 Feb 2002 08:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282845AbSBMNsJ>; Wed, 13 Feb 2002 08:48:09 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:63726 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S282843AbSBMNrz>; Wed, 13 Feb 2002 08:47:55 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020205054709.GA3245@hst000004380um.kincannon.olemiss.edu> 
In-Reply-To: <20020205054709.GA3245@hst000004380um.kincannon.olemiss.edu> 
To: Benjamin Pharr <ben@benpharr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: choice Help Sections 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Feb 2002 13:47:48 +0000
Message-ID: <16763.1013608068@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ben@benpharr.com said:
> Has anyone else noticed the availability of only one help section in
> "choice" blocks when using make menuconfig (and others maybe?)? 

> The best example of this is selection of "Processor family". No matter
> which option is highlighted when Help is selected, it always gives the
> help for CONFIG_M386.

AFAIK the help text for choice entries has _always_ been implemented the 
way you observed - a single entry with the name of the first choice, which 
helps you decide what to choose - not individual entries for each possible 
choice.

It looks like the current Configure.help is broken. I suggest you submit 
patches to correct it.


--
dwmw2


