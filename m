Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUEALkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUEALkx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 07:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUEALkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 07:40:53 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:64426 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261624AbUEALkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 07:40:52 -0400
Message-ID: <40938CD8.4000206@mellanox.co.il>
Date: Sat, 01 May 2004 14:41:12 +0300
From: Eli Cohen <mlxk@mellanox.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: get_user_pages question
References: <1083411131.3844.0.camel@laptop.fenrus.com>
In-Reply-To: <1083411131.3844.0.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>I used 2.4.21-4 (RH AS 3.0).
>>    
>>
>
>I still have grave doubts about what you try to do... is this the code
>at openib.org ? or is there some other URL where the code is visible ?
>
>  
>
It's not in openib since I am not using it since it is not doing what I 
need. The code in openib calls sys_mlock to lock the pages in the 
process's address spcae. In my latst description I meant that the two 
calls to get_user_pages were made on the same buffer.
