Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289014AbSAIUoE>; Wed, 9 Jan 2002 15:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289015AbSAIUnz>; Wed, 9 Jan 2002 15:43:55 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:48624 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S289014AbSAIUnm>; Wed, 9 Jan 2002 15:43:42 -0500
Date: Wed, 9 Jan 2002 12:47:25 -0800
From: Chris Wright <chris@wirex.com>
To: Senhua Tao <stao@nbnet.nb.ca>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: absolute path of a process
Message-ID: <20020109124725.B24733@figure1.int.wirex.com>
Mail-Followup-To: Senhua Tao <stao@nbnet.nb.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C3C8188.E5F7677E@nbnet.nb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3C8188.E5F7677E@nbnet.nb.ca>; from stao@nbnet.nb.ca on Wed, Jan 09, 2002 at 01:44:40PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Senhua Tao (stao@nbnet.nb.ca) wrote:
> Hi,
> 
>     I am new to linux kernel. I like to know is there any way to find
> the absolute path of a process.  I mean, how the kernel  knows which
> process is currently running? I tried to follow  the current  variable
> but got lost. Is the inode struct should I look at?

look at the code in fs/proc/base.c::proc_exe_link(), that should explain
it.

cheers,
-chris
