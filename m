Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268839AbUIMSkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268839AbUIMSkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268844AbUIMSkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:40:32 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:19595 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S268839AbUIMSk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:40:27 -0400
Message-ID: <4145E98F.4050106@colorfullife.com>
Date: Mon, 13 Sep 2004 20:40:15 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Hugh Dickins <hugh@veritas.com>, cmm@us.ibm.com, dipankar@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Put size in array to get rid of barriers in grow_ary()
References: <20040907230936.GA13387@us.ibm.com> <Pine.LNX.4.44.0409081623380.8697-100000@localhost.localdomain> <20040908220753.GD1240@us.ibm.com> <20040911034025.GA8676@us.ibm.com>
In-Reply-To: <20040911034025.GA8676@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:

>And here, finally, is the updated patch.  Still untested.
>
>Thoughts?
>
>  
>
Looks good.
I've even tried to test it, but doesn't compile with -rc1-bk11 due to 
missing rcu_assign_pointer.

--
    Manfred
