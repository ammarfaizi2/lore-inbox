Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274574AbRITRa4>; Thu, 20 Sep 2001 13:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274577AbRITRar>; Thu, 20 Sep 2001 13:30:47 -0400
Received: from [213.96.124.18] ([213.96.124.18]:16875 "HELO dardhal")
	by vger.kernel.org with SMTP id <S274576AbRITRan>;
	Thu, 20 Sep 2001 13:30:43 -0400
Date: Thu, 20 Sep 2001 19:33:05 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Error compiling kernel 2.4.9
Message-ID: <20010920193305.A1625@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109200327570.713-200000@cy60022-a.vnnys1.ca.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0109200327570.713-200000@cy60022-a.vnnys1.ca.home.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 September 2001, at 03:29:43 -0700,
Android wrote:

> I get the following errors while trying to compile kernel 2.4.9:
> unistr.c: In function `ntfs_collate_names':
> unistr.c:99: warning: implicit declaration of function `min'
> 
Know error, and as far as I remember, you have to add the following line:
#include "ntfstypes.h"

to the file unistr.c

Greetings.

--
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

