Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVDEIoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVDEIoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDEIoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:44:17 -0400
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:34568 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S261602AbVDEIoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 04:44:01 -0400
In-Reply-To: <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com> <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no> <c3057294a216d19047bdca201fc97e2f@xs4all.nl> <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cfb514b6a123706d41332b8e5c773fa3@xs4all.nl>
Content-Transfer-Encoding: 7bit
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Dag Arne Osvik <da@osvik.no>,
       Andreas Schwab <schwab@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Kenneth Johansson <ken@kenjo.org>
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: Use of C99 int types
Date: Tue, 5 Apr 2005 10:49:38 +0200
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 4, 2005, at 10:57 PM, Al Viro wrote:

> On Mon, Apr 04, 2005 at 10:30:52PM +0200, Renate Meijer wrote:
>
>> When used improperly. The #define Al Viro objected to, is
>> objectionable. It's highly
>> misleading, as Mr. Viro pointed out. I fail to see where he made
>> comments on stdint.h
>> as such.
>
> Comments on stdint.h are very simple: ...fast... type names are 
> misleading
> in exactly the same way as that define.

Yes. However, the consistent designation ...fast... does alleviate that 
somewhat. It
suffices to remember that in case of 'fast', the width mentioned is a 
minimum value.

>  The fact that they are in standard does not outweight the confusion 
> potential.

I'm not so sure. Again, these types are quite clearly designated, 
something the #define
in question lacks. The other types in stdint.h, however, come in quite 
handy. Specifically
since they are guaranteed to represent correct widths by the 
compiler-guys.

Something to take up with the guys at 'comp.lang.c', i'd say.

Regards,

Renate Meijer.

