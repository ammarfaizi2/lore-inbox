Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317952AbSGPTmu>; Tue, 16 Jul 2002 15:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317953AbSGPTmt>; Tue, 16 Jul 2002 15:42:49 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27910 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317952AbSGPTms>; Tue, 16 Jul 2002 15:42:48 -0400
Date: Tue, 16 Jul 2002 21:45:42 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: Stelian Pop <stelian.pop@fr.alcove.com>,
       Gerhard Mack <gmack@innerfire.net>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716194542.GD22053@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Gerhard Mack <gmack@innerfire.net>,
	Mathieu Chouquet-Stringer <mathieu@newview.com>
References: <20020716124956.GK7955@tahoe.alcove-fr> <Pine.LNX.4.44.0207161107550.17919-100000@innerfire.net> <20020716153926.GR7955@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716153926.GR7955@tahoe.alcove-fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2002, Stelian Pop wrote:

> On Tue, Jul 16, 2002 at 11:11:20AM -0400, Gerhard Mack wrote:
> 
> > In other words you have a backup system that works some of the time or
> > even most of the time... brilliant!
> 
> Dump is a backup system that works 100% of the time when used as 
> it was designed to: on unmounted filesystems (or mounted R/O).

Practical question: how do I get a file system mounted R/O for backup
with dump without putting that system into single-user mode?
Particularly when running automated backups, this is an issue. I cannot
kill all writers (syslog, Postfix, INN, CVS server, ...) on my
production machines just for the sake of taking a backup.
