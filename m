Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283311AbRL1AYy>; Thu, 27 Dec 2001 19:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283591AbRL1AYf>; Thu, 27 Dec 2001 19:24:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:24534 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283311AbRL1AY0>;
	Thu, 27 Dec 2001 19:24:26 -0500
Date: Fri, 28 Dec 2001 01:24:12 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011228002412.GA691@moongate.thevoid.net>
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net> <3C26F2AC.1050809@namesys.com> <20011225004459.GB3752@moongate.thevoid.net> <3C285384.3020302@namesys.com> <20011226005327.GA3970@moongate.thevoid.net> <20011226092024.A871@namesys.com> <20011227030946.GA472@moongate.thevoid.net> <3C2B00B3.4040505@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C2B00B3.4040505@namesys.com>
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 02:06:27PM +0300, Hans Reiser wrote:
> It sounds like you get reiserfs corruptions easily, without crashing the 
> machine or anythin unusual, and in that case you surely have hardware 
> problems.  Please note in our FAQ the discussion of how reiserfs runs 
> hotter than ext2, and it is common for improperly cooled CPUs to work 
> well for ext2 and not reiserfs (tail combining heats the CPU).

not likely; its a duron 700 and lm-sensors says < 37 degree celsius with
open case (as it is now) and about 45 with closed case.

anyway, i've created a new fat32 partition where the old reiserfs one was,
copied lots of files to it and diffed them. no difference. i copied the same
files as earlier to the new reiserfs partition and diffed them. no
difference. no other corrupted files elsewhere, as far as i have seen now.
so whatever was the cause of this seems to have gone now (always the same
kernel, nothing changed with the hardware). perhaps the reiserfs file system
structure got corrupted somehow and thus caused this. don't know. if i have
nothing else to do, i'll create another reiserfs partition where the old one
was and try to corrupt some files.

i'll report back if i get corrupted files again. until then, thanks to
everyone trying to help me and sorry for taking your time.

bye
christian ohm
