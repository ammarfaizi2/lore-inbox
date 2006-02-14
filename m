Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWBNLPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWBNLPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWBNLPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:15:09 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:38592 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161009AbWBNLPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:15:07 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 12:13:16 +0100
To: schilling@fokus.fraunhofer.de, luke@dashjr.org
Cc: seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F1BB4C.nailMWZ118O17@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <200602131722.29633.luke@dashjr.org> <43F0C4A3.nailMEM11MHR7@burner>
 <200602131749.46880.luke@dashjr.org>
In-Reply-To: <200602131749.46880.luke@dashjr.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr <luke@dashjr.org> wrote:

> What does it do "wrong" anyway? IIRC, DMA in general works...

If you really believe that it is good practice to implement DMA in
a way so it works at some places as expected but on others not....

... then you like the Linux kernel be a junk yard :-(

Good practice is to fix _all_ related code in a project in case a bug
is identified and fixed at some place. Unfortunately this is not true
for Linux and for this reason, Linux cannot yet be called mature.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
