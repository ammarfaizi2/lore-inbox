Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbRBTLkJ>; Tue, 20 Feb 2001 06:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130020AbRBTLj7>; Tue, 20 Feb 2001 06:39:59 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:53765 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129778AbRBTLj6>;
	Tue, 20 Feb 2001 06:39:58 -0500
From: thunder7@xs4all.nl
Date: Tue, 20 Feb 2001 12:34:57 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml]2.2.19pre13: Are there network problem with a low-bandwidth link?
Message-ID: <20010220123457.A679@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <Pine.LNX.4.21.0102190828120.190-100000@perfect.master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0102190828120.190-100000@perfect.master>; from tenthumbs@cybernex.net on Mon, Feb 19, 2001 at 08:38:43AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2001 at 08:38:43AM -0500, TenThumbs wrote:
> When I am a) using modem ppp connection and b) downloading a file from a
> reasonably fast server so that the incoming connection is saturated,
> then attempting to open a new network tcp connection while this is going
> on fails quite regularly. The user app gets a ECONNRESET error.
> 
<snip>
> This never happens if the link is idle or lightly loaded. Heavy load is
> extremely important.
> 
I also saw this when my 2.2.19pre12/13 workstation connected to a
2.2.19pre8 isdn-router. When downloading a large file via ftp at max
speed, other connections don't 'get through'.

Perhaps other people can agree/disagree on this?

Jurriaan
-- 
I never deny, I never contradict. I sometimes forget.
        Benjamin Disraeli
GNU/Linux 2.4.1-ac19 SMP/ReiserFS 2x1402 bogomips load av: 0.01 0.06 0.26
