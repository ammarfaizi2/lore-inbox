Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRHQCL3>; Thu, 16 Aug 2001 22:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269454AbRHQCLT>; Thu, 16 Aug 2001 22:11:19 -0400
Received: from tantale.fifi.org ([216.27.190.146]:7071 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S269413AbRHQCLD>;
	Thu, 16 Aug 2001 22:11:03 -0400
To: Kalpesh Shah <kalpesh@cs.utexas.edu>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: <linux-kernel@vger.kernel.org>
Subject: Re: Socket options
In-Reply-To: <Pine.GSO.4.33.0108162055050.24575-100000@cabaco.cs.utexas.edu>
From: Philippe Troin <phil@fifi.org>
Date: 16 Aug 2001 19:11:13 -0700
In-Reply-To: <Pine.GSO.4.33.0108162055050.24575-100000@cabaco.cs.utexas.edu>
Message-ID: <874rr7zb9a.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalpesh Shah <kalpesh@cs.utexas.edu> writes:

> I would like to be CC'ed any answers/comments to my question.
> 
> are /proc/sys/net/ipv4/tcp_rmem and /proc/sys/net/ipv4/tcp_wmem the socket
> Buffer (receive and send respectively) Sizes in the linux kernel.
> 
> If yes then how come when I try to set these buffer sizes by using the
> SO_RCVBUFF and SO_SNDBUFF variables it automatically multiplies the values
> by 2 ????

To remain BSD-compatible.

There was a thread about this on lkml one week ago. Check the
archives.
