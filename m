Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314411AbSEFNPI>; Mon, 6 May 2002 09:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSEFNPH>; Mon, 6 May 2002 09:15:07 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:38673 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314411AbSEFNPH>; Mon, 6 May 2002 09:15:07 -0400
Message-Id: <200205061311.g46DBUX15881@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Chris Rankin <cj.rankin@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 floppy driver EATS floppies
Date: Mon, 6 May 2002 16:17:41 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200205051317.g45DHIU0000750@twopit.underworld>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 May 2002 11:17, Chris Rankin wrote:
> May  5 13:32:36 twopit kernel: floppy0: sector not found: track 0, head 0,
> sector 6, size 2 May  5 13:32:37 twopit kernel: floppy0: sector not found:
> track 0, head 0, sector 6, size 2 May  5 13:32:37 twopit kernel:
> end_request: I/O error, dev 02:00 (floppy), sector 5 May  5 13:32:37 twopit
> kernel: 2nd bread in fat_access failed

Kernel says there is a bad sector.
Did you verify that your floppy is ok?

OTOH, sector errors shouldn't lead to unkillable processes.
If they do, that's a bug.
--
vda

