Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbSJHRzG>; Tue, 8 Oct 2002 13:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbSJHRzG>; Tue, 8 Oct 2002 13:55:06 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23823 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261327AbSJHRzF>; Tue, 8 Oct 2002 13:55:05 -0400
Message-Id: <200210081754.g98Hsnp25324@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: scsi crash
Date: Tue, 8 Oct 2002 20:48:21 -0200
X-Mailer: KMail [version 1.3.2]
References: <05256C4C.001A6B46.00@dns.searchsoftware.com> <3DA2B6B1.DB194DD6@eyal.emu.id.au>
In-Reply-To: <3DA2B6B1.DB194DD6@eyal.emu.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 October 2002 08:42, Eyal Lebedinsky wrote:
> I am getting a full system lockup trying to access a SCSI tape drive.
>
> I got it at first using an ASUS SC200 (810 based) on one machine, and
> later on a Compaq Proliant 6000, which uses an 875 controller.
>
> The newer driver at sym53c8xx_2 actually dies (full system lockup)
> while being loaded without any message shown.
>
> I assume that the tape drive has a significant problem, and consider
> the "unexpected disconnect" to be an indication of this, however the
> real problem is that after the driver reports this error for about a
> minute (once every 3 seconds) the system locks up hard. It is this
> lockup that do not expect.

Kernel version? config?
--
vda
