Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269236AbTGUHDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 03:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbTGUHDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 03:03:44 -0400
Received: from [203.94.130.164] ([203.94.130.164]:13514 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S269236AbTGUHDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 03:03:42 -0400
Message-ID: <46464.203.113.198.161.1058771919.squirrel@bad-sports.com>
In-Reply-To: <0c4e01c34f56$b2b95ce0$64ee4ca5@DIAMONDLX60>
References: <0c1801c34f50$a9706800$64ee4ca5@DIAMONDLX60>
    <46349.203.113.198.161.1058770320.squirrel@bad-sports.com>
    <0c4e01c34f56$b2b95ce0$64ee4ca5@DIAMONDLX60>
Date: Mon, 21 Jul 2003 17:18:39 +1000 (EST)
Subject: Re: Tried to run 2.6.0-test1
From: "Brett" <generica@email.com>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Reply-To: generica@email.com
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond said:
> "Brett" <generica@email.com> replied to one of my desperate messages
> today.
> I'm sending this personally and to the list.  Again I can't keep up with
> the
> list, so if Brett or anyone else has further advice or questions, please
> contact me directly.
>
>> > By the way, the last line in that README file says that if this is all
>> > too complicated then install the source RPM.  Gee thanks.  I already
>> >  tried "rpm --rebuild" but it assumes an i686.
>>
>> you want rpmbuild
>
> SuSE 8.1 doesn't seem to have it.
>

ahh, jumped in halfway thru thread and didn't know you were on suse

>> rpmbuild --target=i586 --rebuild modutils-*.src.rpm
>
> Oh, it doesn't need --target=i586-intel-linux  :-?  (By the way, the
> reason
> I come up with snarky questions like this one is that I RTFM.  Sigh.)
>

[root@synapse router_firmware]# rpmbuild --target=i586 --rebuild
/tbla/modutils-2.4.21-18.src.rpm

<snip>

Wrote: /usr/src/redhat/RPMS/i586/modutils-2.4.21-18.i586.rpm

works for me on rh9 ... sorry i can't give suse specific help

good luck,

     / Brett
