Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314723AbSEHQwF>; Wed, 8 May 2002 12:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314735AbSEHQwE>; Wed, 8 May 2002 12:52:04 -0400
Received: from tantale.fifi.org ([216.27.190.146]:1180 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S314723AbSEHQvy>;
	Wed, 8 May 2002 12:51:54 -0400
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Amol Lad <dal_loma@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: kill task in TASK_UNINTERRUPTIBLE
In-Reply-To: <20020508140124.79124.qmail@web12408.mail.yahoo.com>
	<200205081519.g48FJEX24062@Port.imtp.ilyichevsk.odessa.ua>
From: Philippe Troin <phil@fifi.org>
Date: 08 May 2002 09:51:34 -0700
Message-ID: <87znzawpk9.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> On 8 May 2002 12:01, Amol Lad wrote:
> > Hi,
> >  Is there any way i can kill a task in
> > TASK_UNINTERRUPTIBLE state ?
> 
> No. Everytime you see hung task in this state
> you see kernel bug.
> 
> Somebody correct me if I am wrong.

Except for processes accessing NFS files while the NFS server is down:
they will be stuck in TASK_UNINTERRUPTIBLE until the NFS server comes
back up again.

Phil.
