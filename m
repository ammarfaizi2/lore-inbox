Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319605AbSIMLd5>; Fri, 13 Sep 2002 07:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319606AbSIMLd4>; Fri, 13 Sep 2002 07:33:56 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:23826 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319605AbSIMLd4>; Fri, 13 Sep 2002 07:33:56 -0400
Message-ID: <3D81CE43.60409@namesys.com>
Date: Fri, 13 Sep 2002 15:38:43 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Ivanov <ivandi@vamo.orbitel.bg>
CC: linux-kernel@vger.kernel.org
Subject: Re: XFS?
References: <Pine.LNX.4.44.0209131011340.4066-100000@magic.vamo.orbitel.bg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Ivanov wrote:

>With ReiserFS this happens sometimes, but much much rarely. May be v4 will
>solve this problem at all.
>
We have a data ordered patch that is waiting for 2.4.21pre1.

V4 uses fully atomic transactions for every fs modifying syscall 
including data, and still goes way faster than v3....

Hans


