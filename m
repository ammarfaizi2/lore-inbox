Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSG2HTP>; Mon, 29 Jul 2002 03:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSG2HTP>; Mon, 29 Jul 2002 03:19:15 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:61925 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S293680AbSG2HTO>; Mon, 29 Jul 2002 03:19:14 -0400
Date: Mon, 29 Jul 2002 15:22:18 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unkillable processes stuck in "D" state running forever
Message-ID: <20020729072218.GL1265@leathercollection.ph>
Mail-Followup-To: Federico Sevilla III <jijo@free.net.ph>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020728102246.GG1265@leathercollection.ph> <20020728113536.GI1265@leathercollection.ph> <200207281311.g6SDBVT29125@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207281311.g6SDBVT29125@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
X-Organization: The Leather Collection, Inc.
X-Organization-URL: http://www.leathercollection.ph
X-Personal-URL: http://jijo.free.net.ph
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 04:09:33PM -0200, Denis Vlasenko wrote:
> D state processes are sitting in kernel code waiting for something to
> happen. It is ok to sit in D state for milliseconds, it is acceptable
> to sit for seconds. If those processes are stuck forever, it's a bug.

The processes I refer to get stuck in D state forever. I have other
processes that are in D state legitimately, and for reasonable amounts
of time depending on the task, but it is only these random processes
that occur once in awhile that stay there forever and drive the load
levels way beyond their normal levels.

> Capture Alt-SysRq-T output and ksymoops relevant part Yes it means you
> should have ksymoops installed and tested, which is easy to get wrong.
> I've done that too often.

It also requires access the console, right? Or is it possible to get a
similar task information dump when logged on remotely via SSH? I have
ksymoops working and tested on both of these systems, and console access
to one of them. It would be great to know what to do to help the kernel
hackers figure out what's going on as soon as the next stuck process
shows up.

 --> Jijo

-- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE
