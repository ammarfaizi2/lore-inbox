Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130764AbQLCUzO>; Sun, 3 Dec 2000 15:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131166AbQLCUzF>; Sun, 3 Dec 2000 15:55:05 -0500
Received: from [212.187.250.66] ([212.187.250.66]:3847 "HELO
	proxy.jakinternet.co.uk") by vger.kernel.org with SMTP
	id <S130764AbQLCUy7>; Sun, 3 Dec 2000 15:54:59 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Alexander Viro
In-Reply-To: <20001202173959.A10166@vana.vc.cvut.cz> <Pine.GSO.4.21.0012021255330.28923-100000@weyl.math.psu.edu>
Subject: Re: corruption
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: 192.168.1.1
Message-ID: <970.3a2aabf8.5cd1e@trespassersw.daria.co.uk>
Date: Sun, 03 Dec 2000 20:24:24 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <Pine.GSO.4.21.0012021255330.28923-100000@weyl.math.psu.edu>,
	Alexander Viro <viro@math.psu.edu> writes:
AV> 
>> > ed fs/buffer.c <<EOF
>> > /unmap_buffer/
>> > /}/i
AV> 		spin_lock(&lru_list_lock);
>> > 		remove_inode_queue(bh);
AV> 		spin_unlock(&lru_list_lock);
>> > .
>> > wq
>> > EOF
AV> 

I applied this on top the the previous SCT patch, and have thrashed
the system harder than I would have dared previously. It's still
running. I feel very comfortable with this, much more so than any
prior 2.4.0t*.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
