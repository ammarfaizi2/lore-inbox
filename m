Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSEaIcu>; Fri, 31 May 2002 04:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSEaIct>; Fri, 31 May 2002 04:32:49 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12806 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315202AbSEaIcs>; Fri, 31 May 2002 04:32:48 -0400
Message-Id: <200205310823.g4V8NbY02391@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Rene Rebe <rene.rebe@gmx.net>, dalecki@evision-ventures.com
Subject: Re: [PATCH] 2.5.18 IDE 73
Date: Fri, 31 May 2002 11:25:19 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <UTC200205301443.g4UEhvn20167.aeb@smtp.cwi.nl> <3CF630A5.40002@evision-ventures.com> <20020530.170948.846933988.rene.rebe@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2002 13:09, Rene Rebe wrote:
>     Martin Dalecki <dalecki@evision-ventures.com> wrote:
> > Well somehow I have partly to agree. But however having a way to
> > exclude network devices from mounting during mount -a is *very* usefull,
>
> mount -a -t nonfs,nocoda,noproc,nodevfs,noshm"
>
> Ever worked for me ...

#man mount
...
	For example, the command:
        	mount -a -t nomsdos,ext
	mounts all file systems except those of type msdos and ext.
...

It says you shouldn't repeat 'no' prefix. 
--
vda
