Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262512AbREUWEo>; Mon, 21 May 2001 18:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262509AbREUWEe>; Mon, 21 May 2001 18:04:34 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:60251 "EHLO
	think.thunk.org") by vger.kernel.org with ESMTP id <S262506AbREUWE1>;
	Mon, 21 May 2001 18:04:27 -0400
Date: Mon, 21 May 2001 18:04:05 -0400
From: Theodore Tso <tytso@valinux.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew McNamara <andrewm@connect.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: Ext2, fsync() and MTA's?
Message-ID: <20010521180405.D495@think.thunk.org>
Mail-Followup-To: Theodore Tso <tytso@valinux.com>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andrew McNamara <andrewm@connect.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E14ya9b-0004Bc-00@the-village.bc.nu> <20010512145338.0D3D6285BF@wawura.off.connect.com.au> <20010521184758.B24682@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010521184758.B24682@redhat.com>; from sct@redhat.com on Mon, May 21, 2001 at 06:47:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 06:47:58PM +0100, Stephen C. Tweedie wrote:
>
> No --- the old BSDs were safe because their directory operations were
> fully synchronous so they *never* needed to be sync'ed manually.
> According to SuS, an application relying on sync directory updates is
> buggy, because SuS simply makes no such guarantees.
> 
> Just set chattr +S on the spool dir.  That's what the flag is for.
> The biggest problem with that is that it propagates to subdirectories
> and files --- would a version of the flag which applied only to
> directories be a help here?
> 

That's probably the right thing to add.

						- Ted
