Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVLANq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVLANq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVLANq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:46:27 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:61113 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932233AbVLANq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:46:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tKXhgx94tJSsT8W7JJY7ViJeTn9zfU5djut+vo9Q80Lni45VCaPxub4neeZ97CvkwiFYg1Mog1RKec7G4VZOBITYxUQeetc1wzzs4/0RTajVPsTxoYPw/1N5jinbCM6hg0JfV0A6gBnngvC1Jy/wBiiv7c9dhk+a5FZPqBh+kOE=
Message-ID: <438EFEAB.3010005@gmail.com>
Date: Thu, 01 Dec 2005 22:46:19 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 10/11] blk: add FUA support
 to IDE
References: <20051124162449.209CADD5@htj.dyndns.org>	 <20051124162449.94344DD0@htj.dyndns.org> <58cb370e0511300305w635081e4iacf883fa3746f5d8@mail.gmail.com>
In-Reply-To: <58cb370e0511300305w635081e4iacf883fa3746f5d8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On 11/24/05, Tejun Heo <htejun@gmail.com> wrote:
> 
>>10_blk_ide-add-fua-support.patch
>>
>>        Add FUA support to IDE.  IDE FUA support makes use of
>>        ->protocol_changed callback to correctly adjust FUA setting
>>        according to transfer protocol change.
>>
>>Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> ACK, except ->protocol_changed part
> (IDE needs fixing if you want dynamic barrier changes, sorry)

I'll just leave FUA support for IDE out for the time being.  It's not 
like we have lots of (any?) PATA disks which support FUA anyway.  Thanks 
for your time.

-- 
tejun
