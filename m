Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289317AbSAIJwl>; Wed, 9 Jan 2002 04:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289315AbSAIJwX>; Wed, 9 Jan 2002 04:52:23 -0500
Received: from mx1.evotecoai.com ([194.45.20.20]:3594 "EHLO mx1.evotecoai.com")
	by vger.kernel.org with ESMTP id <S288569AbSAIJwO>;
	Wed, 9 Jan 2002 04:52:14 -0500
To: linux-kernel@vger.kernel.org
Subject: IRIX NFS server/ Linux NFS client problem
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFCEFB95FA.A1E904F6-ONC1256B3C.00358EBC@evotecoai.com>
From: Nicolas.Fay@evotecoai.com
Date: Wed, 9 Jan 2002 10:45:39 +0100
X-MIMETrack: Serialize by Router on MX1/Evotec(Release 5.0.8 |June 18, 2001) at 01/09/2002
 10:43:36 AM,
	Serialize complete at 01/09/2002 10:43:36 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering whether anybody experienced problems with Linux NFS clients 
and IRIX NFS servers like this one:

I mount an xfs-filesystem located on an IRIX-machine v6.5.12 to a Linux 
box (versions see below) using either Linux kernel-nfs or module-nfs. 
Listing directory contents shows all the files present. Using the 
completion functionality fails in showing the complete list of all the 
files that are present. I'm pretty sure it's not a problem with large 
files. All kinds of files are affected and it's even worse: the error is 
not reproducible, i.e. yesterday 'these' files were missing in the 
'TAB-completion-list', today other files are missing. And it happens with 
both shells bash and tcsh. It's not obvious which kinds of files are 
affected.

This does not seem to be a serious issue but rather an annoying one, but 
it slightly rocks my confidence in the nfs code (don't know whether IRIX 
or Linux) and I suspect that not only the completion function fails but 
for example also file selection using shell scripts.

I'm using Kernel 2.4.17, glibc 2.2.4, bash 2.0.5 (SuSE 7.3 installation).

I'd appreciate your opinions.

Thanks in advance,
Nicolas Fay

