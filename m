Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132006AbRC1QUc>; Wed, 28 Mar 2001 11:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131976AbRC1QUO>; Wed, 28 Mar 2001 11:20:14 -0500
Received: from geos.coastside.net ([207.213.212.4]:49577 "EHLO geos.coastside.net") by vger.kernel.org with ESMTP id <S131988AbRC1QT5>; Wed, 28 Mar 2001 11:19:57 -0500
Mime-Version: 1.0
Message-Id: <p05100802b6e7be93e37d@[207.213.214.34]>
In-Reply-To: <20010329013602.I10910@higherplane.net>
References: <Pine.LNX.4.30.0103280225460.8046-100000@coredump.sh0n.net> <01032806093901.11349@tabby> <20010328151008.D8235@dev.sportingbet.com> <20010329013602.I10910@higherplane.net>
Date: Wed, 28 Mar 2001 08:18:10 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Disturbing news..
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 john slee <indigoid@higherplane.net> says:

>On Wed, Mar 28, 2001 at 03:10:08PM +0100, Sean Hunter wrote:
>> On Wed, Mar 28, 2001 at 06:08:15AM -0600, Jesse Pollard wrote:
>> > Sure - very simple. If the execute bit is set on a file, don't allow
>> > ANY write to the file. This does modify the permission bits slightly
>> > but I don't think it is an unreasonable thing to have.
>> >
>>
>> Are we not then in the somewhat zen-like state of having an "rm" which can't
>> "rm" itself without needing to be made non-executable so that it can't execute?
>
>aiiiieee, my head hurts now, thanks :(

It shouldn't. rm is not prevented from removing an unwriteable file (though it complains by default). Directory permissions control operations on links.

-- 
/Jonathan Lundell.
