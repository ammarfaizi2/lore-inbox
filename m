Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSEPJEs>; Thu, 16 May 2002 05:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSEPJEr>; Thu, 16 May 2002 05:04:47 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:37131 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316608AbSEPJEr>; Thu, 16 May 2002 05:04:47 -0400
Message-Id: <200205160901.g4G91jY16662@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC][PATCH] iowait statistics
Date: Thu, 16 May 2002 12:04:09 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0205132214480.32261-100000@imladris.surriel.com> <200205151200.g4FC0MY13196@Port.imtp.ilyichevsk.odessa.ua> <3CE362B0.CA79EB33@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2002 05:41, Andrew Morton wrote:
> > What, even local APIC interrupts did not happen on CPU#3
> > in these five mins?
>
> CPU1 is busy:
>
> quad:/home/akpm> cat /proc/interrupts ; sleep 10 ; cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
> LOC:     142543     142543     142542     142542
> LOC:     143545     143545     143544     143544

Ok, local ints *are* delivered just fine
--
vda
