Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWGFShZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWGFShZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWGFShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:37:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5730 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750723AbWGFShY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:37:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rgh53rT7PmOVjnspeCnXrGPTuZWkGbPUP4gieIdZWK4GeEvJSub76LsGr1aHJ314bZylZKVAetTAZaf6E48qVUrYGG5rfMJ4zX+ZtCJaFwS7Mm7q9YVoO5WgEWNt1WkhEw2mhwtW93gfmM3PVPRmLrnN2WkW001dZgon7+LW+mg=
Message-ID: <d120d5000607061137r605a08f9ie6cd45a389285c4a@mail.gmail.com>
Date: Thu, 6 Jul 2006 14:37:22 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Dave Jones" <davej@redhat.com>, arjan@infradead.org, mingo@redhat.com,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: lockdep input layer warnings.
In-Reply-To: <20060706173411.GA2538@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060706173411.GA2538@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/06, Dave Jones <davej@redhat.com> wrote:
> One of our Fedora-devel users picked up on this this morning
> in an 18rc1 based kernel.
>
>                Dave
>
>
>  Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
>  serio: Synaptics pass-through port at isa0060/serio1/input0
>  input: SynPS/2 Synaptics TouchPad as /class/input/input1
>  PM: Adding info for serio:serio2
>
>  =============================================
>  [ INFO: possible recursive locking detected ]
>  ---------------------------------------------

False alarm, there was a lockdep annotating patch for it in -mm.

-- 
Dmitry
