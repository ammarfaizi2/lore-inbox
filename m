Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbTFSJfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 05:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbTFSJfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 05:35:38 -0400
Received: from sea2-f55.sea2.hotmail.com ([207.68.165.55]:26897 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265756AbTFSJfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 05:35:37 -0400
X-Originating-IP: [194.7.240.2]
X-Originating-Email: [lode_leroy@hotmail.com]
From: "lode leroy" <lode_leroy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: REQ for Kconfig
Date: Thu, 19 Jun 2003 11:49:35 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F55JNT2kNs827K0002bb16@hotmail.com>
X-OriginalArrivalTime: 19 Jun 2003 09:49:35.0980 (UTC) FILETIME=[17B52AC0:01C33648]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'd like to propose something for Kconfig:

I've spent hours to get Linux-2.5 to run. I was stuck with no virtual 
terminals
because by default these depend on 'input' which was compiled as a module.

I think it would be easier to see that an option is disabled instead of 
hiding it.
Then one would look into the 'help' of that option and see that it's 
disabled
because of some other option.

So maybe in 'menuconfig' in the global options a new option 'Show all 
options'
and in each menu
[ ]      -> choosable
< >    -> modulable
[*]     -> chosen
<M>   -> as module
[-]      -> disabled

in this case, I was not seeing the fact that 'Virtual Terminals' depended on 
'input'
which was compiled as a module...

-- lode

_________________________________________________________________


