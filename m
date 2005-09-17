Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVIQLQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVIQLQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 07:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVIQLQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 07:16:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:60315 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751072AbVIQLQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 07:16:53 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Date: Sat, 17 Sep 2005 14:16:20 +0300
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com>
In-Reply-To: <432AFB44.9060707@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509171416.21047.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 September 2005 20:05, Hans Reiser wrote:
> All objections have now been addressed so far as I can discern.

Random observation:

You can declare functions even if you never use them.
Thus here you can avoid using #if/#endif:

#if defined(REISER4_DEBUG) || defined(REISER4_DEBUG_MODIFY) || defined(REISER4_DEBUG_OUTPUT)
int znode_is_loaded(const znode * node /* znode to query */ );
#endif

--
vda
