Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281430AbRKEXdd>; Mon, 5 Nov 2001 18:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281429AbRKEXdX>; Mon, 5 Nov 2001 18:33:23 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:3006 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281428AbRKEXdJ>; Mon, 5 Nov 2001 18:33:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: andersen@codepoet.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Tue, 6 Nov 2001 00:35:54 +0100
X-Mailer: KMail [version 1.3.1]
Cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0111051638230.27028-100000@duckman.distro.conectiva> <160sXt-0LMrdQC@fmrl04.sul.t-online.com> <20011105155955.A16505@codepoet.org>
In-Reply-To: <20011105155955.A16505@codepoet.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <160tEV-20u3KSC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 November 2001 23:59, Erik Andersen wrote:
> Come now, it really isn't that difficult:
>     if (sscanf(line, "%4u %4u %llu %s", &major, &minor, &size, name) == 4)
>     {
> 	add_partition(name, size, major, minor);
>     }

But how can the user know this without looking into the kernel? Compare it to 
/proc/mounts. Proc mounts escapes spaces and other special characters in 
strings with an octal encoding (so spaces are replaced by '\040'). 

bye...
