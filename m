Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277362AbRJJSyS>; Wed, 10 Oct 2001 14:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277363AbRJJSyI>; Wed, 10 Oct 2001 14:54:08 -0400
Received: from [213.98.126.44] ([213.98.126.44]:20996 "HELO anano.mitica")
	by vger.kernel.org with SMTP id <S277362AbRJJSxz>;
	Wed, 10 Oct 2001 14:53:55 -0400
To: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
Cc: Chmouel Boudjnah <chmouel@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: APM on a HP Omnibook XE3
In-Reply-To: <200108301443355.SM00167@there> <m2elobn7a3.fsf@anano.mitica>
	<m3sncrh9u8.fsf@giants.mandrakesoft.com>
	<200110101943880.SM00161@there>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200110101943880.SM00161@there>
Date: 10 Oct 2001 20:54:23 +0200
Message-ID: <m2het7jpgg.fsf@anano.mitica>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "robert" == Robert Szentmihalyi <robert.szentmihalyi@entracom.de> writes:

>> > For me Fn+F12 works.
robert> unfortunately not for me....

You need to have a partition created with the recovery CD, it don't
work if you create it with normal fdisk (and it will destroy your data
in the disk, do a backup first).

z>> > apm -s & apm -S fails.
>> 
>> works only if you have a suspend-on-disk partition.
robert> I have created one with lphdisk and it works under Win2k...

robert> The HP support people say the new omnibook BIOS is not APM 
robert> compilant any more.

I have the omnibook lastest BIOS as end of July, it will work only
with Fn+F12.  I don't remind the version, can check when rebooting.

robert> ACPI only...

robert> Suspend-to-disk with API is not yet supported and I can't use 
robert> software suspend because of reiserfs

robert> I guess I have to wait for proper hibernation support with ACPI....

I am also waiting for it, as I can not suspend to RAM, but suspend to
disk is working nicely here (what is an advantage while waiting).

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
