Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbRDADEZ>; Sat, 31 Mar 2001 22:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRDADEQ>; Sat, 31 Mar 2001 22:04:16 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:31392 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131953AbRDADEI>; Sat, 31 Mar 2001 22:04:08 -0500
From: Christoph Rohland <cr@sap.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs in 2.4.3 and AC
In-Reply-To: <20010330161837.A1052@werewolf.able.es>
Organisation: SAP LinuxLab
In-Reply-To: <20010330161837.A1052@werewolf.able.es>
Message-ID: <m3k855ddls.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 01 Apr 2001 05:11:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2001, jamagallon@able.es wrote:
> tmpfs (or shmfs or whatever name you like) is still different in
> official series (2.4.3) and in ac series. Its a kick in the ass for
> multiboot, as offcial 2.4.3 does not recognise 'tmpfs' in fstab:
> 
> shmfs  /dev/shm        tmpfs   ...

Use type shm. It works in both versions.

> Any reason, or is because it has been forgotten ?

Alan picked up the tmpfs extensions. Linus didn't.

Greetings
		Christoph


