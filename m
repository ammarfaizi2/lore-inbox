Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132682AbRC2IET>; Thu, 29 Mar 2001 03:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132683AbRC2IEK>; Thu, 29 Mar 2001 03:04:10 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:18437 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S132682AbRC2IEA>; Thu, 29 Mar 2001 03:04:00 -0500
Message-ID: <3AC2EC2F.BA7B4868@idb.hist.no>
Date: Thu, 29 Mar 2001 10:02:55 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Ben Ford <ben@kalifornia.com>, linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
In-Reply-To: <01032806093901.11349@tabby> <Pine.GSO.3.96.1010328144551.7198A-100000@laertes> <F6Om1QA+9ew6EwTq@sis-domain.demon.co.uk> <20010328100440.A5941@zalem.puupuu.org> <ZEABaXAGggw6EwTH@sis-domain.demon.co.uk> <3AC1D1B8.9080507@kalifornia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Ford wrote:
> 

> There are two problems I see here.  First, there are several known ways
> to elevate privileges.  
Fixable, except from guessing the root password which is hard.

> If a virus can elevate privileges, then it owns
> you.  Second, this is a multi-OS virus.  If you dual-boot into Windows,
> any ELF files accessible can be infected.  With this one, that isn't a
> prob, but when somebody codes in an ext2 driver to their virus, then
> we've got issues.

And the only cure then is not make your linux fs accessible from
windows.  I.e. not on a disk for which windows have a driver
installed.  Preferably not the same computer.

Or simply "don't run untrusted executables under windows".  Do
so in linux only, where protection applies.  Do anybody ever
_need_ to run a program they got in the mail?

Helge Hafting
