Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSHZCzK>; Sun, 25 Aug 2002 22:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSHZCzK>; Sun, 25 Aug 2002 22:55:10 -0400
Received: from dsl-65-188-232-225.telocity.com ([65.188.232.225]:4495 "EHLO
	area51.underboost.net") by vger.kernel.org with ESMTP
	id <S317855AbSHZCzK>; Sun, 25 Aug 2002 22:55:10 -0400
Subject: Re: swap memory
From: Ron Henry <dijital1@underboost.net>
To: net reel <netreel@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020826024955.9286.qmail@linuxmail.org>
References: <20020826024955.9286.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Aug 2002 18:17:02 -0400
Message-Id: <1030313822.395.17.camel@illuminati>
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



