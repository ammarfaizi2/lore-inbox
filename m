Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262053AbTCVIGh>; Sat, 22 Mar 2003 03:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262054AbTCVIGh>; Sat, 22 Mar 2003 03:06:37 -0500
Received: from calc.cheney.cx ([207.70.165.48]:26587 "EHLO calc.cheney.cx")
	by vger.kernel.org with ESMTP id <S262053AbTCVIGh>;
	Sat, 22 Mar 2003 03:06:37 -0500
Date: Sat, 22 Mar 2003 02:17:40 -0600
From: Chris Cheney <ccheney@cheney.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: KT400 / HPT372 Bug
Message-ID: <20030322081740.GS13034@cheney.cx>
References: <20030322073832.GR13034@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322073832.GR13034@cheney.cx>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 01:38:32AM -0600, Chris Cheney wrote:
> I recently aquired a Abit KD7-RAID motherboard which includes a HPT372
> ide chip. I have tried kernel 2.4.21-pre5-ac3 and it does not work
> correctly with the HPT372 included with my board.  I tried to use a
> 2.5.65+ kernel but both refuse to boot for some unknown reason (only
> loading kernel is displayed).

I just realized that the error I am seeing on 2.4 is from partition
detection code on my ls-120 drive. The bug I was seeing on 2.4.20 must
have been fixed already. However I do think there is still a bug on
2.5.65+ on the driver, I will look into it further once I can manage to
boot a 2.5 kernel again.

Thanks,

Chris Cheney
