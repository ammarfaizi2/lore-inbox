Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSGCF1L>; Wed, 3 Jul 2002 01:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316916AbSGCF1K>; Wed, 3 Jul 2002 01:27:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:42258 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316912AbSGCF1K>; Wed, 3 Jul 2002 01:27:10 -0400
Message-Id: <200207030526.g635Q6T25581@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: khromy@lnuxlab.ath.cx (khromy), linux-kernel@vger.kernel.org,
       ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
Date: Wed, 3 Jul 2002 08:25:45 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020703022051.GA2669@lnuxlab.ath.cx>
In-Reply-To: <20020703022051.GA2669@lnuxlab.ath.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2002 00:20, khromy wrote:
> When I copy a file(13Megs) from /home/ to /tmp/, sync takes almost 2
> minutes. When I copy the same file to /usr/local/, sync returns almost
> right away.  Both filesystems are ext3 and are on the same harddrive.  When
> sync is running, the harddrive light stays on but I don't hear it doing
> anything. dmesg doesn't show any errors either. Below is the `time` output
> for each command.  If you need anymore information  let me know..

Can be useful:
* strace -r sync
* ksymoopsed SysRq-T output (sync part only)
--
vda
