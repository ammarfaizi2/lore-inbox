Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbVHaBPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVHaBPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 21:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVHaBPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 21:15:15 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:9240 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932321AbVHaBPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 21:15:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HW1OfZhWWWYRVoG6o0VwiU+Ck/uBGxsIs8XBS/Lsv3NkCOCG2RBonvhislD6EASAyzoAa/OlGNzoCfkx1EhrYw4k77946Uf6oqANkESP3+BjiDod+flDS4cQZbqUKatyXnZdWPfWEiefpulILVBn8sKfOvcENStqvZzSUKtsIzM=
Message-ID: <4315048A.1020907@gmail.com>
Date: Wed, 31 Aug 2005 09:14:50 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>,
       Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de>
In-Reply-To: <43149E5B.7040006@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:
> fb_pad_aligned_buffer() is also slower for those cases. But does anybody
> use such fonts?

Yes, there are 16x30 fonts out there in the wild. 

Tony
