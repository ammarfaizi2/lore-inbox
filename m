Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSALUU2>; Sat, 12 Jan 2002 15:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSALUUU>; Sat, 12 Jan 2002 15:20:20 -0500
Received: from 213-98-126-44.uc.nombres.ttd.es ([213.98.126.44]:57764 "HELO
	mitica.trasno.org") by vger.kernel.org with SMTP id <S287408AbSALUUK>;
	Sat, 12 Jan 2002 15:20:10 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de,
        andersen@codepoet.org
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <20020110231849.GA28945@kroah.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20020110231849.GA28945@kroah.com>
Date: 12 Jan 2002 21:16:21 +0100
Message-ID: <m2r8ovjpey.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "greg" == Greg KH <greg@kroah.com> writes:

Hi

greg> To summarize, here's a partial list of the programs people want to run:
greg> - mount
greg> - hotplug
greg> - busybox
greg> - dhcpcd
greg> - image viewer
greg> - mkreiserfs
greg> - partition discovery (currently in the kernel)
greg> - lots of other, existing in kernel code.

I still think that fsck at this point will be great.  You will
minimize the need to have the kernel special case for fsck the root fs
with respect to the rest of fs.

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
