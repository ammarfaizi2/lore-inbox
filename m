Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUCBQyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 11:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUCBQyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 11:54:49 -0500
Received: from terminus.zytor.com ([63.209.29.3]:62607 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261706AbUCBQyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 11:54:47 -0500
Message-ID: <4044BC48.7060903@zytor.com>
Date: Tue, 02 Mar 2004 08:54:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: "James H. Cloos Jr." <cloos@jhcloos.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
References: <20040301184512.GA21285@hobbes.itsari.int>	<c2175f$6hn$1@terminus.zytor.com> <m3u1175miy.fsf@lugabout.jhcloos.org>
In-Reply-To: <m3u1175miy.fsf@lugabout.jhcloos.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James H. Cloos Jr. wrote:
>>>>>>"Peter" == H Peter Anvin <hpa@zytor.com> writes:
> 
> Peter> As RBJ said, ptys are now recycled in pid-like fashion, which
> Peter> means numbers won't be reused until wraparound happens.
> 
> Ouch.  I've been using the tty name in $HISTFILE for some time now
> (at least on laptops and workstations); I do not see any reasonable
> alternative to prevent overwriting while still saving history.
> 

????

> Will patching in the old behavior wrt re-use, while not disrupting
> the other improvements, be a lot of work?  I've looked thru the src, 
> but haven't yet spotted the point where the new pis number is chosen.

Not a lot of work, but the performance would suffer big time.

