Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281454AbRKVSwy>; Thu, 22 Nov 2001 13:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281337AbRKVSwp>; Thu, 22 Nov 2001 13:52:45 -0500
Received: from AGrenoble-101-1-5-109.abo.wanadoo.fr ([80.11.136.109]:65156
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281326AbRKVSwh> convert rfc822-to-8bit; Thu, 22 Nov 2001 13:52:37 -0500
Message-ID: <3BFD4A42.8090002@wanadoo.fr>
Date: Thu, 22 Nov 2001 19:56:02 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: James A Sutherland <jas88@cam.ac.uk>, war <war@starband.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <Pine.LNX.4.33L.0111221456020.1491-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Thu, 22 Nov 2001, James A Sutherland wrote:
>>Obviously, there are cases where removing swap breaks the system
>>entirely, but even in other cases, adding swap should *never* degrade
>>performance. (In theory, anyway; in practice, it still needs
>>tuning...)
>>
> 
> Not quite true.  The VM cannot look into the future, so if
> you have swap it could have just swapped out the application
> on the desktop you're about to switch to ;)


I tend to agree. Especially since in some cases (i.e. after
a long compilation (read : lots of code)), the VM has the most
excellent idea to swap out all the GUI (X+apps) and everyone
here knows how long it can be to restore the GUI in that case.

Obviously the problem is very much lessened, in my case, when
i put the swap partition on the *other* drive than the root fs.
Both are ATA100 (40GB 60GXPs), and the system is more responsive
with swap on hdc while / in on hda, than both on hda.

François

