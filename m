Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTEPOAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 10:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTEPOAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 10:00:32 -0400
Received: from www02.ies.inet6.fr ([62.210.153.202]:20123 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S264444AbTEPOAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 10:00:31 -0400
Message-ID: <3EC4F1FD.4010603@inet6.fr>
Date: Fri, 16 May 2003 16:13:17 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix support for SiS5581/5582/5596 IDE
References: <20030516160222.A19746@ucw.cz>
In-Reply-To: <20030516160222.A19746@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>Hi!
>
>The last patch for SiS96* also added support for SiS5581, SiS5582 and
>SiS5596. However, the PCI IDs for these three chips were incorrect by
>mistake (cut and paste problem). This patch, on top of the previous one
>fixes it, and thus adds proper support for these old chips.
>  
>

Thanks for the work.
I've yet to read carefully each change (will do this week-end), but I 
agree on the principles.

The only thing that disturbed me was the removal of the DEBUG code (as 
it often helped me find out bugs and understand new chips' behavior) but 
I think it's best for me to maintain a patch which adds this code in the 
very rare cases where it can be usefull.

LB.

