Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUCHIfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 03:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUCHIfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 03:35:20 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:43470 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S261998AbUCHIfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 03:35:16 -0500
From: Gilad Ben-Yossef <gilad@benyossef.com>
Organization: Codefidence
To: "Pravin Nanaware , Gurgaon" <pnanaware@ggn.hcltech.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Debugging ISR
Date: Mon, 8 Mar 2004 10:33:11 +0200
User-Agent: KMail/1.5
References: <5F0021EEA434D511BE7300D0B7B6AB530E88C2B1@mail2.ggn.hcltech.com>
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB530E88C2B1@mail2.ggn.hcltech.com>
X-Cabal: "There is no IGLU Cabal"
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081033.11951.gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 March 2004 09:28, Pravin Nanaware , Gurgaon wrote:

> I am writing an ISR for Block device driver. Could somebody suggest
> anything on debugging of the ISR as I think ISR is not  executing
> properly.
>

kgdb is usefull for these situations:

http://kgdb.sourceforge.net/

So is printk() :-)

Gilad

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
Codefidence. A name you can trust (TM)
http://www.codefidence.com

