Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267382AbTAGLqL>; Tue, 7 Jan 2003 06:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTAGLqL>; Tue, 7 Jan 2003 06:46:11 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44166
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267382AbTAGLqK>; Tue, 7 Jan 2003 06:46:10 -0500
Subject: Re: Undelete files on ext3 ??
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, maxvaldez@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@redhat.com
In-Reply-To: <200301071130.h07BURnq000165@darkstar.example.net>
References: <200301071130.h07BURnq000165@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041943165.20658.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Jan 2003 12:39:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 11:30, John Bradford wrote:
> > > There is no simple way, no.
> > What about IDE Taskfile access, it's help says something like it's the
> > crown jewel of hard drive forensics.
> 
> What *is* IDE Taskfile access exactly?
> 
> I assumed it was a way of accessing a list of queued commands in the
> device that had not been processed yet.

Its a more formalised interface to issue commands to the controller. 
Each IDE command has a series of phases you have to issue in the
right order. The taskfile ioctls ensure you can issue pretty much
any command safely

