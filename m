Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbUJWPzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUJWPzu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 11:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUJWPzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 11:55:50 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:20437 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261213AbUJWPzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 11:55:46 -0400
Message-ID: <417A7EF9.70007@namesys.com>
Date: Sat, 23 Oct 2004 08:55:37 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>, vs <vs@thebsh.namesys.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Nikita Danilov <Nikita@namesys.com>
Subject: Re: 2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org> <20041023143721.GB5110@stusta.de>
In-Reply-To: <20041023143721.GB5110@stusta.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adrian Bunk wrote:

>
>
>The REISER4_LARGE_KEY option must not be present if reiser4 was merged.
>
>Depending on the compile-time setting of this option, there are two 
>incompatible reiser4 file systems.
>
>cu
>Adrian
>
>  
>
vs, I have yet to see a user do anything other than get confused by this 
option. Please make large keys the default, and hide the ability to 
choose small keys by taking it out of the configuration menu and burying 
it in a .h file.

Hans
