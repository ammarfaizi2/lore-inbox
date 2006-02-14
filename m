Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbWBNIRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWBNIRl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbWBNIRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:17:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:20184 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030513AbWBNIRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:17:40 -0500
Date: Tue, 14 Feb 2006 09:17:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: hpa@zytor.com, linux-kernel@vger.kernel.org, drepper@redhat.com,
       austin-group-l@opengroup.org
Subject: Re: The naming of at()s is a difficult matter
In-Reply-To: <43F09320.nailKUSI1GXEI@burner>
Message-ID: <Pine.LNX.4.61.0602140916440.7198@yvahk01.tjqt.qr>
References: <43EEACA7.5020109@zytor.com> <Pine.LNX.4.61.0602121137090.25363@yvahk01.tjqt.qr>
 <43F09320.nailKUSI1GXEI@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > I have noticed that the new ...at() system calls are named in what
>> > appears to be a completely haphazard fashion.  In Unix system calls,
>> > an f- prefix means it operates on a file descriptor; the -at suffix (a
>> > prefix would have been more consistent, but oh well) similarly
>> > indicates it operates on a (directory fd, pathname) pair.
>> >
>> shmat operates on dirfd/pathname?
>
>Do you have a better proposal for naming the interfaces?
>

chownfn maybe. (fd + name)



Jan Engelhardt
-- 
