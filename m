Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290977AbSBGAIc>; Wed, 6 Feb 2002 19:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290984AbSBGAIX>; Wed, 6 Feb 2002 19:08:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22031 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290977AbSBGAIK>; Wed, 6 Feb 2002 19:08:10 -0500
Subject: Re: kernel: ldt allocation failed
To: jakub@redhat.com
Date: Thu, 7 Feb 2002 00:21:22 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <20020206163118.E21624@devserv.devel.redhat.com> from "Jakub Jelinek" at Feb 06, 2002 04:31:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YcJW-0006vG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is not possible, since then %gs:0 (which is TLS base) cannot be read.
> We would have to change the TLS ABI (thus become incompatible e.g. with Sun)

Sun who have canned their x86 product it seems. I don't feel "the standard
requires we suck" is an appropriate justification for anything. If there 
is not a sane way to follow the standard - break it. If there is a sane way
then all fair and good, find it and use it


Alan
