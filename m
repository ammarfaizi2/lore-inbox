Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTFLRlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbTFLRlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:41:06 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:50954 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S264921AbTFLRk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:40:57 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Thu, 12 Jun 2003 19:54:41 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
cc: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc7 ACPI broken
In-Reply-To: <20030612164211.GE1501@iain-vaio-fx405>
Message-ID: <Pine.OSF.4.51.0306121851390.301711@tao.natur.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A847E96F22@orsmsx401.jf.intel.com>
 <Pine.OSF.4.51.0306121825500.300337@tao.natur.cuni.cz>
 <20030612164211.GE1501@iain-vaio-fx405>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jun 2003, iain d broadfoot wrote:

> * Martin MOKREJ? (mmokrejs@natur.cuni.cz) wrote:
> > Hi,
> >   so I retried the latest patch available from sourceforge site, but that
> > is for pre-2.4.21-rc3 candidate. Even worse, some parsed applied with
> > offset and in one or two cases got rejected! So I have to wait if patch for
> > -rc8 appears or for anything newer. Anyone successfully applied
> > acpi-20030523-2.4.21-rc3.diff.gz 7b9551e86393a58d8e6c2b3aeeea2f16
> > (md5sum)?
>
> the rc3 acpi patch should apply cleanly to everything upto and including
> rc8 (it did for me, anyway. :D).

Against -rc8 I got:

patching file Documentation/Configure.help
Hunk #1 succeeded at 18665 (offset 20 lines).
patching file Documentation/kernel-parameters.txt

but no rejects, that's true. The kernel  2.4.21-rc8-acpi-20050522 works
fine now. Thanks. I'm too lazy to repeat patching plain -rc3. :(

-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
