Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSHZDRs>; Sun, 25 Aug 2002 23:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSHZDRs>; Sun, 25 Aug 2002 23:17:48 -0400
Received: from dsl-65-188-232-225.telocity.com ([65.188.232.225]:6799 "EHLO
	area51.underboost.net") by vger.kernel.org with ESMTP
	id <S317858AbSHZDRr>; Sun, 25 Aug 2002 23:17:47 -0400
Subject: Re: swap memory
From: Ron Henry <dijital1@underboost.net>
To: net reel <netreel@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020826024955.9286.qmail@linuxmail.org>
References: <20020826024955.9286.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Aug 2002 23:22:51 -0400
Message-Id: <1030332172.8980.0.camel@illuminati>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-25 at 22:49, net reel wrote:
> Hi, I have a very newbie question but I couldnt get an answer in anywhere so please, could someone explain me how swap is initialized? Is it initalized when the kernel is decompressed or when the init scripts are called? 
> 
Swap is initialized when one of the init scripts runs swapon which makes
a call to sys_swapon defined in mm/swapfile.c


dijital1

"Unix is simple and coherent, but it takes a genius (or a programmer at
any rate) to understand and appreciate it's simplicity" - Dennis Ritchie


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


