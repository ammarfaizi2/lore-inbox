Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316355AbSEOGuj>; Wed, 15 May 2002 02:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316356AbSEOGui>; Wed, 15 May 2002 02:50:38 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:6917 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316355AbSEOGuh>; Wed, 15 May 2002 02:50:37 -0400
Message-Id: <200205150647.g4F6ljY12346@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Diego SANTA CRUZ <Diego.SantaCruz@epfl.ch>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: `modprobe agpgart` locks machine badly
Date: Wed, 15 May 2002 09:50:20 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Alex Brotman <atbrotman@earthlink.net>
In-Reply-To: <1021363885.2781.10.camel@ltspc67>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2002 06:11, Diego SANTA CRUZ wrote:
> I did a bit of debugging some time ago with the datasheets from intel.
> If i remember well, the problem was that the base of the aperture is not
> initialized by the BIOS (i.e. the APBASE register of the AGP bridge).
>
> This is visible in the lspci listing above, in that the Region 0 memory
> is "<unassigned>". On the machines that I have seen with agpgart
> working, the address of Region 0 is the address that appears in the
> APBASE register.

Can it be set manually with setpci?
--
vda
