Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbULRVEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbULRVEE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 16:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbULRVEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 16:04:04 -0500
Received: from quark.didntduck.org ([69.55.226.66]:10678 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261161AbULRVEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 16:04:01 -0500
Message-ID: <41C49B3D.5040802@didntduck.org>
Date: Sat, 18 Dec 2004 16:03:57 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joseph Seigh <jseigh_02@xemaps.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: What does atomic_read actually do?
References: <opsi7o5nqfs29e3l@grunion>  <1103394867.4127.18.camel@laptopd505.fenrus.org> <opsi7xcuizs29e3l@grunion> <1103399680.4127.20.camel@laptopd505.fenrus.org> <opsi707edhs29e3l@grunion>
In-Reply-To: <opsi707edhs29e3l@grunion>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Seigh wrote:
> On Sat, 18 Dec 2004 20:54:40 +0100, Arjan van de Ven 
> <arjan@infradead.org>  wrote:
> 
>> On Sat, 2004-12-18 at 14:20 -0500, Joseph Seigh wrote:
>>
>>> I mean atomic in the either old or new sense.  I'm wondering what
>>> guarantees
>>> the atomicity.  Not the C standard.  I can see the gcc compiler uses 
>>> a  MOV
>>> instruction to load the atomic_t from memory which is guaranteed 
>>> atomic  by
>>> the architecture if aligned properly.  But gcc does that for any old int
>>> as far as I can see, so why use atomic_read?
>>
>>
>> it does so on *x86
> 
> 
> Is this documented for gcc anywhere?  Just because it does so doesn't
> mean it's guaranteed.
> 
> Joe Seigh

ftp://download.intel.com/design/Pentium4/manuals/25366814.pdf

Chapter 7, section 1

--
				Brian Gerst
