Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSANPpP>; Mon, 14 Jan 2002 10:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSANPo4>; Mon, 14 Jan 2002 10:44:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50184 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286959AbSANPow>; Mon, 14 Jan 2002 10:44:52 -0500
Message-ID: <3C42FCD4.90209@zytor.com>
Date: Mon, 14 Jan 2002 07:44:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Christoph Rohland <cr@sap.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tmpfs accounting (was: losetuping files in tmpfs fails?)
In-Reply-To: <3C35F8B2.98763627@sltnet.lk> <a181kp$tl4$1@cesium.transmeta.com> <m3pu4daysi.fsf_-_@linux.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland wrote:

> 
> I would not like to add the real size without a bigger goal (I would
> not see a problem with a fake size).
> 


It defeats the filesystem size limit, and makes it possible to an 
unprivileged user to consume unlimited amounts of kernel memory.

	-hpa

