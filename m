Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSK0Haj>; Wed, 27 Nov 2002 02:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSK0Haj>; Wed, 27 Nov 2002 02:30:39 -0500
Received: from ns.tasking.nl ([195.193.207.2]:32269 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S261286AbSK0Hai>;
	Wed, 27 Nov 2002 02:30:38 -0500
Message-ID: <15844.30218.125658.999394@koli.tasking.nl>
Date: Wed, 27 Nov 2002 08:36:42 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: modutils for both redhat kernels and 2.5.x
In-Reply-To: <20021126013330.93A962C365@lists.samba.org>
References: <20021126013330.93A962C365@lists.samba.org>
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: Kees Bakker <rnews@altium.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Xref: koli.tasking.nl archive.outgoing.2002-11:9
X-Gnus-Article-Number: 9   Tue Nov 26 14:25:04 2002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rusty" == Rusty Russell <rusty@rustcorp.com.au> writes:

>> The command line args for modprobe are laughingly few (and none of
>> the ones a redhat system needs to boot are implemented.)

Rusty> Really?  I don't recall seeing a bug report from you about it.  My
Rusty> Debian system boots fine.

My Debian system doesn't load the modules anymore. And I have asked this on
the mailinglist last week, but nobody seemed to care :-(

I am curious how your Debian system was able to boot without problems. On
my system I have configured quite a few modules, and some of them seem to
be loaded by hotplug and some by init scripts. All I see is a lot of
commandline errors from modprobe, and a lot of messages like
  QM_MODULES: Function not implemented

		Kees
