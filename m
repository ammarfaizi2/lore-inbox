Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbULPTBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbULPTBT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbULPTBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:01:18 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:56487 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261989AbULPS6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:58:08 -0500
Message-ID: <41C1DABF.2050004@namesys.com>
Date: Thu, 16 Dec 2004 10:58:07 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Steve French <smfrench@austin.rr.com>, cliff white <cliffw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: cifs large write performance improvements to Samba
References: <41BDC9CD.60504@austin.rr.com> <20041213092057.5bf773fb.cliffw@osdl.org> <41BDE0B4.6020003@austin.rr.com> <41BDE2CF.9060402@austin.rr.com> <20041216121151.GH8246@logos.cnet>
In-Reply-To: <20041216121151.GH8246@logos.cnet>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>
>> I have not seen anyone 
>>doing that on Linux in an automated fashion (e.g running iozone 
>>automated every time a new 2.6.x.rc on a half a dozen of the fs - simply 
>>to verify that things had not gotten drastically worse on a particular 
>>fs due to a bug or sideffect of a global VFS change).
>>    
>>
>
>Yes, we definately need that.
>
>  
>
Andrew Morton is saying that iozone does things real apps don't do, that 
is, it dirties mmap'd pages enough to swamp the machine.

Do you guys agree or disagree with that?

Reiser4 needs iozone optimization work which we haven't bothered with yet.
