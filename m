Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWFWOix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWFWOix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWFWOix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:38:53 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:60542 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750795AbWFWOiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:38:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=h5ZqbwsYFycDWpHmMG1+An8b45TmfhyQFhuhmg3Ql2/VDdQBQfztgvwyDcLQWZt/Y2tAdA2GkMbRUpQLb/odKxydqLT1hVbSnTif3dIu7zzKinN1BYXKXwNnrMr0HL/I5EhSf4bLdKJfK6OzGOUiZXeq+QujD+JcrEg+dHADUOk=
Message-ID: <449BFCF6.1000603@gmail.com>
Date: Fri, 23 Jun 2006 22:38:46 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
References: <200606211715.58773.a1426z@gawab.com> <200606222036.45081.a1426z@gawab.com> <449ADCB2.4000006@gmail.com> <200606231625.39904.a1426z@gawab.com>
In-Reply-To: <200606231625.39904.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Antonino A. Daplas wrote:
>> (vgacon's screenbuffer is video RAM while the rest of the console drivers
>> have it in system RAM. But you can have vgacon and fbcon compiled at the
>> same time, for example, and this basically screws up the screen accessors,
>> especially in non-x86 archs.)
>>
>> So a revamp of vgacon may be necessary, by placing the screen buffer in
>> system RAM. This will entail a lot of work, so the revamp will take some
>> time.
> 
> Thanks for looking into this.
> 
>>> VIA has a separate driver, couldn't this be merged with mainline?
>> Sure, as long as it's GPL-compatible, properly written, and correctly
>> Signed-off.
> 
> Attached below is their license.  Is it GPL-compatible?

The license text is MIT. A note from the author explicitly stating GPL
compatibility or dual-licensing the code is much better. 

Also, I prefer that the author of the code himself submit it for inclusion.

Tony
