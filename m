Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316799AbSFJJzZ>; Mon, 10 Jun 2002 05:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316804AbSFJJzY>; Mon, 10 Jun 2002 05:55:24 -0400
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:9921
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S316799AbSFJJzX>; Mon, 10 Jun 2002 05:55:23 -0400
Message-ID: <3D04777D.2040705@st-peter.stw.uni-erlangen.de>
Date: Mon, 10 Jun 2002 11:55:09 +0200
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re:  2.5.21: "ata_task_file: unknown command 50"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *17HLtG-0004cp-00*gYLq/K.qaPM* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>raid0_make_request bug: can't convert block across chunks or bigger than 
>64k 94712 8
>raid0_make_request bug: can't convert block across chunks or bigger than 
>64k 1340144 12
>raid0_make_request bug: can't convert block across chunks or bigger than 
>64k 1342192 20

that's a problem of the raid-0 code
it needs a request splitter and/or more bio changes
it's here since 2.5.5 AFAIK 
are you using raid

i'm useing lvm over soft raid-0 and i can not mount my
xfs LV's because of that

svetljo  





