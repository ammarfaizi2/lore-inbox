Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278277AbRJWUwq>; Tue, 23 Oct 2001 16:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278271AbRJWUwg>; Tue, 23 Oct 2001 16:52:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46602 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278282AbRJWUwW>; Tue, 23 Oct 2001 16:52:22 -0400
Message-ID: <3BD5D886.8080206@zytor.com>
Date: Tue, 23 Oct 2001 13:52:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org
Subject: Re: [Q] pivot_root and initrd
In-Reply-To: <Pine.LNX.3.95.1011023164253.21024A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> On Tue, 23 Oct 2001, Werner Almesberger wrote:
> 
> 
>>H. Peter Anvin wrote:
>>
>>>The right thing is to get rid of the old initrd compatibility cruft,
>>>but that's a 2.5 change.
>>>
>>Yes, change_root is obsolete (and relies on assumptions that are no
>>longer valid in several cases), and there has been plenty of time for
>>distributors to switch. An early funeral in 2.5 is a good idea.
>>
> 
> Hmm. I need to install a SCSI driver, presumably from initrd
> RAM disk as currently works. Will the new pivot-root be transparent?
> 


It's not transparent, you need to change your initrd.

	-hpa


