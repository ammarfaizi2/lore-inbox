Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269165AbUICEka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269165AbUICEka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269153AbUICEk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:40:29 -0400
Received: from pointblue.com.pl ([81.219.144.6]:34323 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S269074AbUICEkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:40:14 -0400
Message-ID: <4137F5AA.3020009@pointblue.com.pl>
Date: Fri, 03 Sep 2004 06:40:10 +0200
From: =?UTF-8?B?R3J6ZWdvcnogSmHFm2tpZXdpY3o=?= <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: Rik van Riel <riel@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <200408261034.38509.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com> <20040826121223.GG30449@mail.shareable.org>
In-Reply-To: <20040826121223.GG30449@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh, and if I may notice something more. Just my opinion.
It's going to be 'samba uses only' thing, as long as it's not in VFS.
xattrs are not so much needed as file streams there. So argument that 
xattrs exists already in VFS, and are not used, so why do we need 
streams there, and that it wouldn't change anything is just silly.

Btw, reiserfs4 on my laptop is providing very nice base for KDE source 
tree (XFS sucked so much, I had to replace it). Saving me some time on 
recompilation, and cvs up.

Thanks.

--
GJ
