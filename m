Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbREBILB>; Wed, 2 May 2001 04:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbREBIKw>; Wed, 2 May 2001 04:10:52 -0400
Received: from [195.6.125.97] ([195.6.125.97]:55309 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S131472AbREBIKj>;
	Wed, 2 May 2001 04:10:39 -0400
Date: Wed, 2 May 2001 10:08:16 +0200
From: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: ioctl call for network device
Message-Id: <20010502100816.61389ed6.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've succeed to do an ioctl call and recept it in my module

ioctl(file_descriptor, cmd, struct ifreq)

but I believe that I'm oblige to use the struct ifreq and I can't
pass any other arguments because an user can't acces kernel space
so the ioctl call recopy data in the kernel space (this is what I've
understood, maybe I'm wrong ...).

My problem is that I need to pass some int arguments (the best way was an
int* ) but the struct ifreq doesn't permit me it, so could I add other
arguments as we can do in an normal ioctl call ?

I hope this is the wrong place for this question.

sebastien person
