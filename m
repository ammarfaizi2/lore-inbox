Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbTKZJqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 04:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTKZJqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 04:46:39 -0500
Received: from imap.gmx.net ([213.165.64.20]:62185 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264112AbTKZJqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 04:46:38 -0500
X-Authenticated: #4512188
Message-ID: <3FC4767B.6050401@gmx.de>
Date: Wed, 26 Nov 2003 10:46:35 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test10-mm1
References: <20031125211518.6f656d73.akpm@osdl.org>
In-Reply-To: <20031125211518.6f656d73.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regression: test10 (plain) yielded higher performance on HD (26mb/s) 
without setting readahead higher then default. Now I must set it to 
10096 to get about the same performance (though not quite reaching 
it:25mb/sec, with 20mb/sec at defaults). Tested with hdparm.

Prakash

