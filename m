Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287832AbSAIUxE>; Wed, 9 Jan 2002 15:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287835AbSAIUwy>; Wed, 9 Jan 2002 15:52:54 -0500
Received: from 216-42-72-164.ppp.netsville.net ([216.42.72.164]:13779 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S287832AbSAIUws>; Wed, 9 Jan 2002 15:52:48 -0500
Date: Wed, 09 Jan 2002 15:52:09 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Oleg Drokin <green@namesys.com>
cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] certain data corruption may cause reiserfs to panic,
 fix.
Message-ID: <344590000.1010609528@tiny>
In-Reply-To: <Pine.LNX.4.21.0201091458360.21044-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0201091458360.21044-100000@freak.distro.conectiva
 >
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 09, 2002 02:58:45 PM -0200 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> On Wed, 9 Jan 2002, Oleg Drokin wrote:
> 
>> Hello!
>> 
>>     Purpose of this patch is to catch events of corrupted ITEM_TYPE
>>     fields, and report these to user. Without this patch, accessing such
>>     items will resukt in dereferencing random memory areas in kernel,
>>     and then ooping (most probably).
>>     Please apply.
> 
> Why corruption is happening in the first place ? 

Oddly, the corruption most often caught by this patch was from the early
redhat gcc 2.96.

-chris

