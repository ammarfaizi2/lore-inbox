Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSIEGDQ>; Thu, 5 Sep 2002 02:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSIEGDQ>; Thu, 5 Sep 2002 02:03:16 -0400
Received: from angband.namesys.com ([212.16.7.85]:24229 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317023AbSIEGDP>; Thu, 5 Sep 2002 02:03:15 -0400
Date: Thu, 5 Sep 2002 10:07:48 +0400
From: Oleg Drokin <green@namesys.com>
To: "David S. Miller" <davem@redhat.com>
Cc: szepe@pinerecords.com, mason@suse.com, reiser@namesys.com,
       shaggy@austin.ibm.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020905100748.A5650@namesys.com>
References: <20020904.223651.79770866.davem@redhat.com> <20020905054858.GI24323@louise.pinerecords.com> <20020905095638.B5351@namesys.com> <20020904.225234.103129147.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020904.225234.103129147.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 04, 2002 at 10:52:34PM -0700, David S. Miller wrote:

>    > And a pretty straightforward one, too. Convert the internal reiserfs
>    > link stuff to an unsigned short, find NLINK_MAX using the code I posted
>    Too bad it is 32bit nlink field in on disk format ;)
> We're only talking about what the user is told is the
> nlink value, not what you happen to compute and put/get
> from disk.

Yes, I just parsed that suggestion above incorrectly ;)

> Your nlink can be legitimately 128-bits if you want, it
> still can be made to work :-)

Yes, I know. That's what I plan to do ;)

Bye,
    Oleg
