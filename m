Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVG1UKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVG1UKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVG1UKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:10:08 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:49242 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261781AbVG1UHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:07:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=oV6aG0AEfmv/2TY51zEOM3kXkaHlqbvzo9BgEdzcTcsWtQOl5hwqNkxI9bSVqDsEXKzEJdq3NO4A4nD42l+yXiJsf6SMMlfc1+QDEWOKqZRjABBYsTX2KeizTV9Qoaj6qfsxfQ2agnKFXJpgrdH2HsC5IaI00ijcl0JEBVrxPYY=
Message-ID: <42E957B5.8040606@gmail.com>
Date: Thu, 28 Jul 2005 22:09:57 +0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050726)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org>
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

I have some questions :-)
Reiser4:

why there are undefined functions implemented that currently not in use?
This messages appeared first time in 2.6.13-rc3-mm2.

Any why it complains even CONFIG_REISER4_DEBUG is not set?
Please have a look at  the -->snip

SCSI:

CONFIG_SCSI_QLA2XXX=y ? I haven't choose that one..I never did..and 
where is the config located?
In the place where it is..is no option marked.

Thanks for help,

Greets
    Michael


--> snip
fs/reiser4/plugin/item/static_stat.c:1158:5: warning: 
"REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/static_stat.c:1176:5: warning: 
"REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/static_stat.c:1194:5: warning: 
"REISER4_DEBUG_OUTPUT" is not defined
fs/reiser4/plugin/item/static_stat.c:1213:5: warning: 
"REISER4_DEBUG_OUTPUT" is not defined
  CC      fs/reiser4/plugin/item/sde.o
In file included from fs/reiser4/plugin/item/../plugin.h:26,
                 from fs/reiser4/plugin/item/sde.c:11:
fs/reiser4/plugin/item/../node/node40.h:83:5: warning: "GUESS_EXISTS" is 
not defined
fs/reiser4/plugin/item/sde.c:21:5: warning: "REISER4_DEBUG_OUTPUT" is 
not defined
  CC      fs/reiser4/plugin/item/cde.o
In file included from fs/reiser4/plugin/item/../plugin.h:26,
                 from fs/reiser4/plugin/item/cde.c:65:
fs/reiser4/plugin/item/../node/node40.h:83:5: warning: "GUESS_EXISTS" is 
not def

