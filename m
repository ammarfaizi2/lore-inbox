Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288521AbSAIRFg>; Wed, 9 Jan 2002 12:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288246AbSAIRF0>; Wed, 9 Jan 2002 12:05:26 -0500
Received: from [216.151.155.108] ([216.151.155.108]:52746 "EHLO
	varsoon.denali.to") by vger.kernel.org with ESMTP
	id <S288661AbSAIRFO>; Wed, 9 Jan 2002 12:05:14 -0500
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: About Loop Device
In-Reply-To: <20020109165518.98129.qmail@web14912.mail.yahoo.com>
From: Doug McNaught <doug@wireboard.com>
Date: 09 Jan 2002 12:04:52 -0500
In-Reply-To: Michael Zhu's message of "Wed, 9 Jan 2002 11:55:18 -0500 (EST)"
Message-ID: <m3r8oz8ngr.fsf@varsoon.denali.to>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Zhu <mylinuxk@yahoo.ca> writes:

> Thanks for the reply. But when I try to use the
> command "mount -o loop /dev/fd0 /floppy", the mount
> returns an error saying "mount: you must specify the
> filesystem type". What is wrong? Thanks.

You probably want losetup(8) instead of mount.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
