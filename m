Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288949AbSAISM4>; Wed, 9 Jan 2002 13:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288954AbSAISMq>; Wed, 9 Jan 2002 13:12:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:14596 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S288949AbSAISM3>; Wed, 9 Jan 2002 13:12:29 -0500
Date: Wed, 9 Jan 2002 14:58:45 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] certain data corruption may cause reiserfs to panic,
 fix.
In-Reply-To: <20020109162207.A15139@namesys.com>
Message-ID: <Pine.LNX.4.21.0201091458360.21044-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jan 2002, Oleg Drokin wrote:

> Hello!
> 
>     Purpose of this patch is to catch events of corrupted ITEM_TYPE fields, and report these to user.
>     Without this patch, accessing such items will resukt in dereferencing random memory areas in kernel,
>     and then ooping (most probably).
>     Please apply.

Why corruption is happening in the first place ? 

