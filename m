Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312826AbSDJLsm>; Wed, 10 Apr 2002 07:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSDJLsl>; Wed, 10 Apr 2002 07:48:41 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:48529 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S312826AbSDJLsk>; Wed, 10 Apr 2002 07:48:40 -0400
From: Christoph Rohland <cr@sap.com>
To: Sean Hunter <sean@dev.sportingbet.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Geoffrey Gallaway <geoffeg@sin.sloth.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Ramdisks and tmpfs problems
In-Reply-To: <20020409144639.A14678@sin.sloth.org>
	<20020410084505.A4493@dev.sportingbet.com>
	<200204101028.g3AAS2X05866@Port.imtp.ilyichevsk.odessa.ua>
	<20020410114521.C4493@dev.sportingbet.com>
Organisation: SAP LinuxLab
Date: Wed, 10 Apr 2002 13:52:37 +0200
Message-ID: <m3662zzs6y.fsf@linux.wdf.sap-ag.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Wed, 10 Apr 2002, Sean Hunter wrote:
>> /dev is for devices, why do you use it for mounting filesystems?
> 
> Normally yes, but the tmpfs provides posix shared memory semantics
> and thus /dev/shm is the "normal" place to mount it.  Don't blame
> me.

Yes, and he does not want to use it for POSIX shared mem, but as a
local filesystem. So he should mount it where he needs it and
definitely not misunse the posix mount for different things.

Greetings
		Christoph


