Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUG2Lmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUG2Lmg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 07:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUG2Lmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 07:42:35 -0400
Received: from vhost12.digitarus.com ([194.242.150.12]:29064 "EHLO
	vhost12.digitarus.com") by vger.kernel.org with ESMTP
	id S264386AbUG2Lmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 07:42:31 -0400
X-ClientAddr: 212.126.40.83
Message-ID: <4108E29A.5080609@wiggly.org>
Date: Thu, 29 Jul 2004 12:42:18 +0100
From: Nigel Rantor <wiggly@wiggly.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Chris Wedgwood <cw@f00f.org>, peter@chubb.wattle.id.au,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: stat very inefficient
References: <233602095@toto.iv>	<16648.10711.200049.616183@wombat.chubb.wattle.id.au>	<20040728154523.20713ef1.davem@redhat.com>	<20040729000837.GA24956@taniwha.stupidest.org> <20040728171414.5de8da96.davem@redhat.com>
In-Reply-To: <20040728171414.5de8da96.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Digitarus-vhost12-MailScanner-Information: Please contact Digitarus for more information
X-Digitarus-vhost12-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 28 Jul 2004 17:08:37 -0700
> Chris Wedgwood <cw@f00f.org> wrote:
> 
> 
>>Just How bad is it for you?  I just tested stat on my crapbox and for
>>a short path 1M stats takes 0.5s and for a longer path (30 bytes or
>>so) 2.8s.
> 
> 
> Run "time find . -type f" on the kernel tree, both before and
> after removing the third unnecessary copy.  Many machines sit all
> day and stat files.

P2 350MHz 256Mb RAM circa 1998

bash$ time find . -type f

gives

real    0m16.142s
user    0m0.432s
sys     0m2.893s

I'd be interested to see what machine you have that takes all day.

   N
