Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313156AbSDIJi1>; Tue, 9 Apr 2002 05:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313830AbSDIJi0>; Tue, 9 Apr 2002 05:38:26 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8466 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313156AbSDIJiZ>; Tue, 9 Apr 2002 05:38:25 -0400
Message-Id: <200204090934.g399YbX02006@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Anssi Saari <as@sci.fi>, Mark Mielke <mark@mark.mielke.cc>
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Date: Tue, 9 Apr 2002 12:37:50 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020408122603.GA7877@sci.fi> <20020408174529.A546@mark.mielke.cc> <20020409083243.GB23043@sci.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 April 2002 06:32, Anssi Saari wrote:
> On Mon, Apr 08, 2002 at 05:45:29PM -0400, Mark Mielke wrote:
> > The question is, how is CD burning of raw data different from
> > CD burning of ISO images, in respect to Linux drivers for the
> > hardware
>
> As far as I know, when burning an ISO image, the image has 2048 byte
> sectors to which the CD writer adds error correction data so that the
> individual sector becomes 2352 bytes. A raw data image includes 2352 byte
> sectors. The obvious difference would be a higher data rate (2352/2048
> or 1.15x more) from computer to writer.

It means different write command, additional (possibly less carefully
written/tested) driver code etc. You may need to track your problem
up to that driver code.
--
vda
