Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVC1LKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVC1LKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 06:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVC1LKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 06:10:30 -0500
Received: from mail3.euroweb.net.mt ([217.145.4.38]:20356 "EHLO
	mail3.euroweb.net.mt") by vger.kernel.org with ESMTP
	id S261525AbVC1LKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 06:10:21 -0500
Message-ID: <4247E62B.5080900@euroweb.net.mt>
Date: Mon, 28 Mar 2005 13:10:35 +0200
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: EXPORT_SYMBOL question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have 2 modules. The first one uses EXPORT_SYMBOL to make some function 
available to other modules. These prototypes for these functions were 
also put in a header file. Now the second module uses the functions the 
functions defined in the first module by and includes the afore 
mentioned header file. However when i'm compiling the module, I get a 
symbol underfined warning. When I load the module it works as expected. 
Is there any way to get rid of these warnings.

Another problem I'm having is that when I load the second module I get 
`no version for "rbnode_initialize" found: kernel tainted.' 
(rbnode_initialize is one of the functions exported by the first 
module). Both MODULE_LICENSE("GPL"); and MODULE_VERSION are declared in 
the two modules. Is there anything I'm missing?

Thanks
Josef Galea
