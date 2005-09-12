Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVILVdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVILVdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVILVdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:33:14 -0400
Received: from [64.162.99.240] ([64.162.99.240]:35716 "EHLO
	spamtest2.viacore.net") by vger.kernel.org with ESMTP
	id S932110AbVILVdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:33:13 -0400
Message-ID: <4325F3D5.9040109@spamtest.viacore.net>
Date: Mon, 12 Sep 2005 14:32:05 -0700
From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
References: <43228E4E.4050103@jg555.com> <p73k6hp2up7.fsf@verdi.suse.de> <43229BA4.4010306@pobox.com> <20050910163446.GA2232@taniwha.stupidest.org>
In-Reply-To: <20050910163446.GA2232@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
>> /lib64 is an awful scheme.  I'd avoid it.
> I'd like to see people move away from it before it gets too entrenched
> too.

agreed -- as far as i'm concerned the 32 bit libraries are there for 
compatibility's sake and should be in /lib/compat/<subarch> instead of 
/lib. the native libraries should be in /lib instead of /lib64. lib64 
should just go away!

but then again, nobody asked for *my* input before this fhs spec came 
out, so ...

-kelsey
