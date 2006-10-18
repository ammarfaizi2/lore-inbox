Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWJRSMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWJRSMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422750AbWJRSMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:12:43 -0400
Received: from av2.karneval.cz ([81.27.192.122]:12860 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1422751AbWJRSMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:12:42 -0400
Message-ID: <45366D12.3070200@gmail.com>
Date: Wed, 18 Oct 2006 20:06:10 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Sven Hoexter <shoexter@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] nfs client: Read-only file system (2.6.19-rc1,2)
References: <4534F59D.4040505@gmail.com> <1161104051.5559.5.camel@lade.trondhjem.org> <eh4hhb$sp7$1@sea.gmane.org> <4535EB4F.4070406@gmail.com> <45364C51.2000004@gmail.com> <1161192121.6095.58.camel@lade.trondhjem.org> <453667F1.4040504@gmail.com> <20061018180233.GF5374@fieldses.org>
In-Reply-To: <20061018180233.GF5374@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:
> On Wed, Oct 18, 2006 at 07:44:17PM +0200, Jiri Slaby wrote:
>> Trond Myklebust wrote:
>>> I'll bet that you have always had a subdirectory of the exact same
>>> filesystem mounted somewhere else ro, right?
>> Yup, exactly: /usr -ro and /home -rw on the same (hda3) partition.
> 
> Just out of curiosity--why are you doing that?

Not me :). I do not admin that machine.

> On the linux server, at least, that doesn't really prevent writing to
> /usr unless you've also turned on subtree checking.  And subtree
> checking causes other problems.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
