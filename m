Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266183AbSKUAi5>; Wed, 20 Nov 2002 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266199AbSKUAi5>; Wed, 20 Nov 2002 19:38:57 -0500
Received: from [155.223.251.1] ([155.223.251.1]:48035 "HELO gatekeeper")
	by vger.kernel.org with SMTP id <S266183AbSKUAi4>;
	Wed, 20 Nov 2002 19:38:56 -0500
From: "Halil Demirezen" <nitrium@bilmuh.ege.edu.tr>
To: "Rusty Lynch" <rusty@linux.co.intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Coding style question] XXX_register or register_XXX
Date: Thu, 21 Nov 2002 03:02:06 +0800
Message-Id: <20021121030206.M48633@bilmuh.ege.edu.tr>
In-Reply-To: <001701c290ef$8417f020$94d40a0a@amr.corp.intel.com>
References: <001701c290ef$8417f020$94d40a0a@amr.corp.intel.com>
X-Mailer: Open WebMail 1.64 20020415
X-OriginatingIP: 217.131.251.13 (nitrium)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there an accepted standard on naming for registration functions?  
> If have a foo object that other things can register and unregister 
> with, should the function names be:
> int foo_register(&something);
> int foo_unregister(&something);

really, that would make the entire kernel code a little 
simplier to understand.
On the same way, we can say why there is not an accepted standard on
naming lock functions, such as
 
   spinlock, rwlock and so on..

That would be more efficient to understand the code...
However, where is flexibility?


-hd
