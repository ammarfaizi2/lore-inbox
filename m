Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSG2IVx>; Mon, 29 Jul 2002 04:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSG2IVx>; Mon, 29 Jul 2002 04:21:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:41484 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313305AbSG2IVw>; Mon, 29 Jul 2002 04:21:52 -0400
Message-Id: <200207290819.g6T8JOT31352@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Federico Sevilla III <jijo@free.net.ph>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unkillable processes stuck in "D" state running forever
Date: Mon, 29 Jul 2002 11:17:24 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020728102246.GG1265@leathercollection.ph> <200207281311.g6SDBVT29125@Port.imtp.ilyichevsk.odessa.ua> <20020729072218.GL1265@leathercollection.ph>
In-Reply-To: <20020729072218.GL1265@leathercollection.ph>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 July 2002 05:22, Federico Sevilla III wrote:
> On Sun, Jul 28, 2002 at 04:09:33PM -0200, Denis Vlasenko wrote:
> > D state processes are sitting in kernel code waiting for something to
> > happen. It is ok to sit in D state for milliseconds, it is acceptable
> > to sit for seconds. If those processes are stuck forever, it's a bug.
>
> The processes I refer to get stuck in D state forever. I have other
> processes that are in D state legitimately, and for reasonable amounts
> of time depending on the task, but it is only these random processes
> that occur once in awhile that stay there forever and drive the load
> levels way beyond their normal levels.
>
> > Capture Alt-SysRq-T output and ksymoops relevant part Yes it means you
> > should have ksymoops installed and tested, which is easy to get wrong.
> > I've done that too often.
>
> It also requires access the console, right? Or is it possible to get a
> similar task information dump when logged on remotely via SSH?

It is logged by syslog. /var/log/messages if your conf is standard.
--
vda
