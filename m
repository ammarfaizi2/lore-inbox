Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUAFMpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbUAFMpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:45:12 -0500
Received: from firewall.conet.cz ([213.175.54.250]:34701 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262123AbUAFMpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:45:08 -0500
Message-ID: <3FFAAD76.3060605@conet.cz>
Date: Tue, 06 Jan 2004 13:43:34 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@colin2.muc.de>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?)
References: <1aQy3-2y1-7@gated-at.bofh.it> <m3znd139ur.fsf@averell.firstfloor.org> <3FFAAB91.6090207@conet.cz> <20040106123947.GA17607@colin2.muc.de>
In-Reply-To: <20040106123947.GA17607@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>OK - what's correct implementation? Do a "char * tmp_path" and kmalloc it?
>>    
>>
>Use getname()/putname()
>  
>
I thought that these are used for copying data to/from userspace...

-- 

Libor Vanek


